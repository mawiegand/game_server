class Tutorial::QuestsController < ApplicationController
  layout 'tutorial'
  
  before_filter :authenticate
  before_filter :deny_api, :except => [:update]    

  # GET /tutorial/quests
  # GET /tutorial/quests.json
  def index
    respond_to do |format|
      format.html do
        @tutorial_quests = Tutorial::Quest.paginate(:page => params[:page], :per_page => 50)    
        @paginate = true   
      end
    end
  end

  # GET /tutorial/quests/1
  # GET /tutorial/quests/1.json
  def show
    @tutorial_quest = Tutorial::Quest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tutorial_quest }
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
    
    attributes = params[:tutorial_quest]
    if attributes.has_key?(:status) && attributes[:status] == Tutorial::Quest::STATE_DISPLAYED.to_s
      attributes[:displayed_at] = Time.now

      # Send Mail if required
      quest_message = @tutorial_quest.quest[:message]
      unless quest_message.nil?
        Messaging::Message.create_tutorial_message(current_character, quest_message[:de_DE][:subject], quest_message[:de_DE][:body]) # TODO I18n
      end
    end

    respond_to do |format|
      if @tutorial_quest.update_attributes(attributes)
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
