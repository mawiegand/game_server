class Action::Tutorial::MarkQuestRewardDisplayedActionsController < ApplicationController
  
  before_filter :authenticate

  def create
    @action = params[:action_tutorial_mark_quest_reward_displayed_action]
    
    raise BadRequestError.new('no quest_id given') if @action[:quest_id].nil?

    quest = Tutorial::Quest.find_by_id(@action[:quest_id])
    
    raise NotFoundError.new('Quest not found')    if quest.nil?
    raise ForbiddenError.new('Access forbidden.') if quest.tutorial_state.owner != current_character && !admin? && !staff?

    raise BadRequestError.new('Quest already has been displayed')  if quest.has_reward_been_displayed?
    raise BadRequestError.new('Quest is not completed')            if quest.completed?
    
    quest.mark_reward_displayed
    
    if !quest.save
      raise InternalServerError.new('Quest could not be saved after marking reward as displayed')
    end
    
    respond_to do |format|
      format.html { redirect_to action_path, notice: 'Quest reward was successfully marked has having been displayed.' }
      format.json { render json: {}, status: :created }
    end
  end

end
