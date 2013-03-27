class Ticker::BattleHandler
end

require 'ticker/battle_handler/army_summary'
require 'ticker/battle_handler/faction_summary'
require 'ticker/battle_handler/round_summary'

# This class contains general stats about a battle, 
# like the maximum sum damage that a faction produced.
class Ticker::BattleHandler::BattleSummary
	attr_accessor :battle, :max_faction_unit_num, :max_faction_damage_inflicted, :max_faction_casulties, :faction_summaries, :round_summaries, :character_army_summaries 
	
	def initialize(battle)
		@battle = battle

		@max_faction_unit_num = 0;
		@max_faction_damage_inflicted = 0.0;
		@max_faction_casulties = 0;
		
		@faction_summaries = Hash.new
		@round_summaries = Hash.new
		@character_army_summaries = Hash.new

		#-----------------------
		#-- Database requests --
		#-----------------------
		#load the battle rounds
		@rounds = battle.rounds.includes(:faction_results => [{:faction => [{:participants => [:army, :character]}]}, {:participant_results => [:army, {:participant => :character}]} ]).order("round_num")

		#load the participants for the specific user history
		participants = battle.participants.includes(:army, :character => [:alliance])

		#------------------------------
		#-- Summaries initialization --
		#------------------------------
		#initialize the participant summaries
		participants.each do |participant|
			if (@character_army_summaries[participant.character_id].nil?) 
				@character_army_summaries[participant.character_id] = Hash.new
			end
			hash = @character_army_summaries[participant.character_id]
			hash[participant.id] = Ticker::BattleHandler::ArmySummary.new(participant)
			#if empty initialize with the army itself
			if @rounds.empty?
				hash[participant.id].update_with_participant(participant)
			end
		end

		#initialize the round and faction summaries
		@rounds.each do |round|
			@round_summaries[round.id] = Ticker::BattleHandler::RoundSummary.new(round)
			round.faction_results.each do |faction_result|
				if (@faction_summaries[faction_result.faction_id].nil?)
					@faction_summaries[faction_result.faction_id] = Ticker::BattleHandler::FactionSummary.new(faction_result.faction)
				end
			end
		end

		#in case of no rounds do the faction summaries manualy
		if @rounds.empty?
			battle.factions.each do |faction|
				@faction_summaries[faction.id] = Ticker::BattleHandler::FactionSummary.new(faction)
				faction.participants.each do |participant|
					@faction_summaries[faction.id].update_with_participant(participant)
				end
			end
		end

		#---------------------
		#-- Summary updates --
		#---------------------
		#update all the summaries with the participant_results
		joined_participants = Hash.new
		@rounds.each do |round|
			round_summary = @round_summaries[round.id]
			round.faction_results.each do |faction_result|
				faction_summary = @faction_summaries[faction_result.faction_id]
				faction_result.participant_results.each do |participant_result|
					#find if new armies have joined the battle
					is_new_participant = false
					if joined_participants[participant_result.participant_id].nil?
						is_new_participant = true
						joined_participants[participant_result.participant_id] = true
					end
					#TODO detect leader change

					#update the corresponding army summary
					army_summary = @character_army_summaries[participant_result.participant.character_id][participant_result.participant_id]
					army_summary.update_based_on_result(is_new_participant, participant_result)
					#update the faction summaries
					faction_summary.update_based_on_result(is_new_participant, participant_result)
					#update the round summaries
					round_summary.update_based_on_result(true, participant_result)
				end
			end
		end

		#---------------------------
		#-- Update the max values --
		#---------------------------
		@faction_summaries.each do |faction_id, faction_summary|
			if (@max_faction_unit_num < faction_summary.sum_units)
				@max_faction_unit_num = faction_summary.sum_units
			end
			if (@max_faction_casulties < faction_summary.sum_casulties) 
				@max_faction_casulties = faction_summary.sum_casulties
			end
			if (@max_faction_damage_inflicted < faction_summary.sum_damage_inflicted) 
				@max_faction_damage_inflicted = faction_summary.sum_damage_inflicted
			end
		end

	end

	def send_battle_report_messages()
		@character_army_summaries.each do |character_id, army_summaries|
			first_army_summary_key = army_summaries.keys.first
			if !first_army_summary_key.nil?
			  army = army_summaries[first_army_summary_key].army
				character = army.nil? ? Fundamental::Character.find_by_id(character_id) : army.owner
				if character && !character.npc?
					generate_message(character)
				end
			end
		end
	end

	def generate_message(character)
		old_local = I18n.locale
		@locale = character.locale
		if (character.locale.to_s[0,2] == "de")
			I18n.locale = :de
		else
			I18n.locale = :de
		end

		#army summary
		my_army_summaries = @character_army_summaries[character.id];

		#faction overview
		my_faction_summary = get_own_faction_summary(character)
		enemy_faction_summaries = get_enemy_faction_summaries(character)

		@message_template = ERB.new(File.open("app/views/military/battle_messages/report.html.erb", "rb:UTF-8").read)
		@unit_summary_template = ERB.new(File.open("app/views/military/battle_messages/_unit_summary.html.erb", "rb:UTF-8").read)

		Messaging::Message.generate_battle_report_message(character, render(I18n.translate('application.messaging.battle_report.subject')), @message_template.result(binding))
	
		#reset the local the old one  
		I18n.locale = old_local
	end

	#---- HELPER METHODS ------

	def render(template_string)
		template = ERB.new(template_string)
		template.result(binding)
	end

	def get_unit_name(unit_type, character)
		return unit_type[:name][@locale] unless unit_type[:name][@locale].nil?
		return unit_type[:name][:en_US] unless unit_type[:name][:en_US].nil?
		nil
	end

	def get_character_name(character)
		return character.name if character.alliance.nil?
		character.name + " | " +character.alliance.tag
	end

	def render_unit_summary(unit_summary, character)
		rules = GameRules::Rules.the_rules
		@unit_summary_template.result(binding)
	end

	def get_own_faction_summary(character)
		@faction_summaries.each do |faction_key, faction_summary|
			return faction_summary if (faction_summary.faction.contains_army_of(character))
		end
		nil
	end

	def get_enemy_faction_summaries(character)
		result = Array.new
		@faction_summaries.each do |faction_key, faction_summary|
			result.push(faction_summary) unless (faction_summary.faction.contains_army_of(character))
		end
		result
	end

	def percent_of(value, max)
		return 0 unless value > 0
		return 0 unless max > 0
		(value.to_f/max.to_f*100.0)
	end

end