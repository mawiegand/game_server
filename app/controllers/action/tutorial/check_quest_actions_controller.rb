class Action::Tutorial::CheckQuestActionsController < ApplicationController
  
  before_filter :authenticate

  # POST /action/tutorial/check_quest_actions
  # POST /action/tutorial/check_quest_actions.json
  def create
    @action = params[:action_tutorial_check_quest_action]
    
    raise BadRequestError.new('no quest_id given') if @action[:quest_id].nil?
    
    tutorial_state = current_character.tutorial_state
    raise BadRequestError.new('tutorial state not found') if tutorial_state.nil?
    
    quest_id = @action[:quest_id].to_i
    raise BadRequestError.new('quest_id not valid') unless quest_id >= 0
    
    quest_state = tutorial_state.open_quest_state_with_quest_id(quest_id)
    raise BadRequestError.new('quest state not found') if quest_state.nil?

    answer_text = @action[:answer_text]
    browser_request = !use_restkit_api?
    raise BadRequestError.new('check quest rewards failed') unless quest_state.check_for_rewards(browser_request, answer_text)
    quest_state.set_finished 
    quest_state.place_npcs
    quest_state.open_dependent_quest_states

    respond_to do |format|
      format.html { redirect_to action_path, notice: 'Check quest action was successfully executed.' }
      format.json { render json: {}, status: :created }
    end
  end

end
