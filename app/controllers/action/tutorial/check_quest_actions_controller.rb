class Action::Tutorial::CheckQuestActionsController < ApplicationController
  
  before_filter :authenticate

  # POST /action/tutorial/check_quest_actions
  # POST /action/tutorial/check_quest_actions.json
  def create
    @action = params[:action_check_quest_action]
    raise BadRequestError.new('no quest_id given') if @action[:quest_id].nil?
    
    tutorial_state = current_character.tutorial_state
    raise BadRequestError.new('tutorial state not found') if tutorial_state.nil?
    
    quest_id = @action[:quest_id].to_i
    raise BadRequestError.new('quest_id not valid') unless quest_id > 0
    
    quest = tutorial_state.quest_with_id(quest_id)

    quest.check

    respond_to do |format|
      format.html { redirect_to action_path, notice: 'Change army action was successfully executed.' }
      format.json { render json: {}, status: :created }
    end
  end

end
