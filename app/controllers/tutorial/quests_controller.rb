class Tutorial::QuestsController < ApplicationController
  layout 'tutorial'
  
  before_filter :authenticate
  before_filter :deny_api, :except => [:index, :show, :update]    

  # GET /tutorial/quests
  # GET /tutorial/quests.json
  def index
    
    last_modified = nil

    if params.has_key?(:character_id)      # request using character_id 
      
      state = Tutorial::State.find_by_character_id(params[:character_id])
      raise NotFoundError.new('No quests found for character id.')  if state.nil?
      raise ForbiddenError.new('Access forbidden.')                 if state.owner != current_character && !staff? && !admin?
      
      @tutorial_quests = if api_request?   # send only the relevant quests (those, that have not been finished yet)
        state.quests.non_closed    
      else                                 # display all quests in backend
        state.quests.paginate(:page => params[:page], :per_page => 50)                
      end
      last_modified = state.updated_at.utc # the state is touched on changed on the quests
      
    else                                   # request all 
      raise ForbiddenError.new('Access forbidden.')                 if !staff? && !admin? 
      @tutorial_quests = Tutorial::Quest.paginate(:page => params[:page], :per_page => 50)
    end
    
    if stale?(:last_modified => last_modified, :etag => @tutorial_quests)
      respond_to do |format|
        format.html 
        format.json { render json: @tutorial_quests }
      end
    end
  end

  # GET /tutorial/quests/1
  # GET /tutorial/quests/1.json
  def show
    @tutorial_quest = Tutorial::Quest.find(params[:id])
    raise ForbiddenError.new ('Access forbidden.')  unless staff? || admin? || @tutorial_quest.tutorial_state.owner == current_character

    if stale?(:last_modified => @tutorial_quest.updated_at.utc, :etag => @tutorial_quest)
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @tutorial_quest }
      end
    end
  end

  # GET /tutorial/quests/new
  # GET /tutorial/quests/new.json
  def new
    @tutorial_quest = Tutorial::Quest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tutorial_quest }
    end
  end

  # GET /tutorial/quests/1/edit
  def edit
    @tutorial_quest = Tutorial::Quest.find(params[:id])
  end

  # POST /tutorial/quests
  # POST /tutorial/quests.json
  def create
    @tutorial_quest = Tutorial::Quest.new(params[:tutorial_quest])

    respond_to do |format|
      if @tutorial_quest.save
        format.html { redirect_to @tutorial_quest, notice: 'Quest was successfully created.' }
        format.json { render json: @tutorial_quest, status: :created, location: @tutorial_quest }
      else
        format.html { render action: "new" }
        format.json { render json: @tutorial_quest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tutorial/quests/1
  # PUT /tutorial/quests/1.json
  def update
    @tutorial_quest = Tutorial::Quest.find(params[:id])
    
    attributes_sent = params[:tutorial_quest]
    attributes_to_update = {}
    
    raise ForbiddenError.new ("Access to quest state forbidden.") unless admin? || staff? || @tutorial_quest.tutorial_state.owner == current_character
    
    if admin? || staff?
      attributes_to_update = attributes_sent
    else
      attributes_to_update[:status] = attributes_sent[:status]  if attributes_sent.has_key?(:status)
    end
    
    if attributes_to_update.has_key?(:status) && attributes_to_update[:status] == Tutorial::Quest::STATE_DISPLAYED.to_s
      attributes_to_update[:displayed_at] = Time.now

      # Send Mail if required
      #quest_message = @tutorial_quest.quest[:message]
      #
      #if !quest_message.nil? && @tutorial_quest.status < Tutorial::Quest::STATE_DISPLAYED
      #  Messaging::Message.create_tutorial_message(current_character, quest_message[I18n.locale][:subject], quest_message[I18n.locale][:body])
      #end
    end
    
    if attributes_sent.has_key?(:reward_displayed)
      attributes_to_update[:reward_displayed_at] = Time.now
    end

    respond_to do |format|
      if @tutorial_quest.update_attributes(attributes_to_update)
        format.html { redirect_to @tutorial_quest, notice: 'Quest was successfully updated.' }
        format.json { render json: {}, status: :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @tutorial_quest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutorial/quests/1
  # DELETE /tutorial/quests/1.json
  def destroy
    @tutorial_quest = Tutorial::Quest.find(params[:id])
    @tutorial_quest.destroy

    respond_to do |format|
      format.html { redirect_to tutorial_quests_url }
      format.json { head :ok }
    end
  end
end
