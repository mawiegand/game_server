require 'ticker/battle_handler/unit_summary'

class Ticker::BattleHandler::FactionSummary < Ticker::BattleHandler::UnitSummary
	attr_accessor :faction, :participants

	def initialize(faction)
		super()
		@faction = faction
		@participants = Array.new
	end

	def update_with_participant(participant)
		super(participant)
		@participants.push(participant)
	end

	def update_based_on_result(new_participant, participant_result)
		super(new_participant, participant_result)
		@participants.push(participant_result.participant) if new_participant
	end
end