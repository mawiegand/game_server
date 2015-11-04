class Action::Tutorial::MarkCavePaintingDisplayedActionsController < ApplicationController
  
  before_filter :authenticate

  def create
    @action = params[:action_tutorial_mark_cave_painting_displayed_action]
    
    raise BadRequestError.new('no quest_id given') if @action[:quest_id].nil?

    quest = Tutorial::Quest.find_by_id(@action[:quest_id])
    
    raise NotFoundError.new('Quest not found')    if quest.nil?
    raise ForbiddenError.new('Access forbidden.') if quest.tutorial_state.owner != current_character && !admin? && !staff?

    raise BadRequestError.new('Quest is not enabled in cave painting')             unless quest.is_cave_painting_enabled?
    raise BadRequestError.new('Quest is not completed')                            unless quest.completed?
    raise BadRequestError.new('Cave Painting of quest already has been displayed') if quest.has_cave_painting_been_displayed?
    
    quest.mark_cave_painting_displayed
    
    if !quest.save
      raise InternalServerError.new('Quest could not be saved after marking cave painting as displayed')
    end
    
    respond_to do |format|
      format.html { redirect_to action_path, notice: 'Cave painting of Quest was successfully marked has having been displayed.' }
      format.json { render json: {}, status: :created }
    end
  end

end
