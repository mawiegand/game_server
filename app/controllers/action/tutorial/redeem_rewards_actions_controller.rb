class Action::Tutorial::RedeemRewardsActionsController < ApplicationController
  
  before_filter :authenticate

  # POST /action/tutorial/redeem_rewards_actions
  # POST /action/tutorial/redeem_rewards_actions.json
  def create
    @action = params[:action_tutorial_redeem_rewards_action]
    
    raise BadRequestError.new('no quest state id given') if @action[:quest_state_id].nil?
    
    quest_state = Tutorial::Quest.find(@action[:quest_state_id])
    
    # test if character is owner of tutorial_state
    raise BadRequestError.new('no tutorial state given') if quest_state.tutorial_state.nil?
    raise BadRequestError.new('not owner of tutorial state') if quest_state.tutorial_state.owner != current_character

    # check if quest is already finished by user
    if quest_state.status < Tutorial::Quest::STATE_FINISHED  # check again, whether quest is already finished
      raise BadRequestError.new('quest is not finished yet and cannot be finished on the fly') unless quest_state.check_for_rewards(!use_restkit_api?, nil)
      quest_state.set_finished 
      #quest_state.open_dependent_quest_states  # it's ok to run this twice; it only creates not-already-created dependent quests
    end
    
    raise BadRequestError.new('quest is not finished yet') if quest_state.status < Tutorial::Quest::STATE_FINISHED    
    raise BadRequestError.new('rewards already rewarded') if quest_state.status > Tutorial::Quest::STATE_FINISHED

    quest_state.redeem_rewards

    respond_to do |format|
      format.html { redirect_to action_path, notice: 'Redeem rewards action was successfully executed.' }
      format.json { render json: {}, status: :created }
    end
  end

end
