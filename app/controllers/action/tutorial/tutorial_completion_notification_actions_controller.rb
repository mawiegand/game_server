class Action::Tutorial::TutorialCompletionNotificationActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:character_id].nil?
    raise ForbiddenError.new('tried to write-access a different character')  unless params[:character_id].to_i == current_character.id

    current_character.tutorial_states.displayed_tutorial_completion_notice_at = Time.now  
    
    raise InternalServerError.new('could not save tutorial state') unless current_character.tutorial_states.save

    respond_to do |format|
      format.json do 
        render json: {}, status: :ok 
      end
    end
  end
  
end
