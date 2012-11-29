require 'ticker/battle_handler/unit_summary'

class Ticker::BattleHandler::ArmySummary < Ticker::BattleHandler::UnitSummary
	attr_accessor :army, :has_retreated, :destroyed

	def initialize(army)
		super()
		@army = army
		@has_retreated = false
		@destroyed = army.has_units?
	end

	def update_based_on_result(new_army, participant_result)
		super(new_army, participant_result)
		@has_retreated = true if (participant_result.retreat_tried && participant_result.retreat_succeeded)
		@destroyed = true unless ((@sum_units -  @sum_casulties) > 0)
	end
end