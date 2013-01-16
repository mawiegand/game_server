class Action::Tutorial::RedeemTutorialEndRewardsActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create
    tutorial_state = current_character.tutorial_state
    raise BadRequestError.new('tutorial state not found') if tutorial_state.nil?
    raise ForbiddenError.new('tutorial end quest not completed yet') unless tutorial_state.completed_tutorial_end_quest?
    raise ForbiddenError.new('tutorial end rewards already rewarded') if tutorial_state.tutorial_completed

    current_character.redeem_tutorial_end_rewards
    
    tutorial_state.displayed_tutorial_completion_notice_at = Time.now
    tutorial_state.tutorial_completed = true
    
    raise InternalServerError.new('could not save tutorial state') unless tutorial_state.save

    respond_to do |format|
      format.json do 
        render json: {}, status: :ok 
      end
    end
  end
  
end
