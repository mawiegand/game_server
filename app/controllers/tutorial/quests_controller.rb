class Tutorial::QuestsController < ApplicationController
  layout 'tutorial'

  # GET /tutorial/quests
  # GET /tutorial/quests.json
  def index
    @tutorial_quests = Tutorial::Quest.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tutorial_quests }
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

    respond_to do |format|
      if @tutorial_quest.update_attributes(params[:tutorial_quest])
        format.html { redirect_to @tutorial_quest, notice: 'Quest was successfully updated.' }
        format.json { head :ok }
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
