require 'ticker/battle_handler/unit_summary'
require 'ticker/battle_handler/faction_summary'

class Ticker::BattleHandler::RoundSummary < Ticker::BattleHandler::UnitSummary
	attr_accessor :round, :faction_summaries, :new_participants, :retreat_tried_armies, :retreat_succeeded_armies
	
	def initialize(round)
		super()
		@round = round
		@faction_summaries = Hash.new
		@new_participants = Array.new
		@retreat_tried_armies = Array.new
		@retreat_succeeded_armies = Array.new
		#generate faction summaries
		round.faction_results.each do |faction_result|
			@faction_summaries[faction_result.id] = Ticker::BattleHandler::FactionSummary.new(faction_result.faction)
		end
	end

	def update_based_on_result(new_participant, participant_result)
		super(new_participant, participant_result)
		#update faction summaries
		@faction_summaries[participant_result.battle_faction_result_id].update_based_on_result(new_participant, participant_result)
		#new army
		new_participants.push(participant_result.participant) if new_participant
		#check if the there was a try to flee
		if (participant_result.retreat_tried)
			@retreat_tried_armies.push(participant_result.army)
			#save it if there was success
			if (!participant_result.retreat_succeeded.nil? && participant_result.retreat_succeeded)
				retreat_succeeded_armies.push(participant_result.army)
			end
		end
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

end