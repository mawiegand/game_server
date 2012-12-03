require 'ticker/battle_handler/unit_summary'

class Ticker::BattleHandler::FactionSummary < Ticker::BattleHandler::UnitSummary
	attr_accessor :faction, :armies

	def initialize(faction)
		super()
		@faction = faction
		@armies = Array.new
	end

	def update_based_on_result(new_army, participant_result)
		super(new_army, participant_result)
		@armies.push(participant_result.army) if new_army
	end
end