require 'ticker/battle_handler/unit_summary'

class Ticker::BattleHandler::ArmySummary < Ticker::BattleHandler::UnitSummary
	attr_accessor :participant, :army, :has_retreated, :destroyed, :dissolved

	def initialize(participant)
		super()
		@participant   = participant
		@army          = participant.army unless participant.nil?
		@has_retreated = false
		@dissolved     = participant.nil? || participant.army.nil?
		@destroyed     = @dissolved || !participant.army.has_units?
	end

	def update_based_on_result(new_participant, participant_result)
		super(new_participant, participant_result)
		@has_retreated = true if (participant_result.retreat_tried && participant_result.retreat_succeeded)
		@destroyed     = true unless (!@dissolved && (@sum_units -  @sum_casulties) > 0)
	end
end