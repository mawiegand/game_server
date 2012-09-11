class Military::BattleParticipantsController < ApplicationController
  layout 'military'

  before_filter :authenticate
  before_filter :authorize_staff, :except => [:show, :index]
  before_filter :deny_api,        :except => [:show, :index]


  # GET /military/battle_participants
  # GET /military/battle_participants.json
  def index
    @military_battle_participants = Military::BattleParticipant.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @military_battle_participants }
    end
  end

  # GET /military/battle_participants/1
  # GET /military/battle_participants/1.json
  def show
    @military_battle_participant = Military::BattleParticipant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @military_battle_participant }
    end
  end

  # GET /military/battle_participants/new
  # GET /military/battle_participants/new.json
  def new
    @military_battle_participant = Military::BattleParticipant.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @military_battle_participant }
    end
  end

  # GET /military/battle_participants/1/edit
  def edit
    @military_battle_participant = Military::BattleParticipant.find(params[:id])
  end

  # POST /military/battle_participants
  # POST /military/battle_participants.json
  def create
    @military_battle_participant = Military::BattleParticipant.new(params[:military_battle_participant])

    respond_to do |format|
      if @military_battle_participant.save
        format.html { redirect_to @military_battle_participant, notice: 'Battle participant was successfully created.' }
        format.json { render json: @military_battle_participant, status: :created, location: @military_battle_participant }
      else
        format.html { render action: "new" }
        format.json { render json: @military_battle_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /military/battle_participants/1
  # PUT /military/battle_participants/1.json
  def update
    @military_battle_participant = Military::BattleParticipant.find(params[:id])

    respond_to do |format|
      if @military_battle_participant.update_attributes(params[:military_battle_participant])
        format.html { redirect_to @military_battle_participant, notice: 'Battle participant was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @military_battle_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /military/battle_participants/1
  # DELETE /military/battle_participants/1.json
  def destroy
    @military_battle_participant = Military::BattleParticipant.find(params[:id])
    @military_battle_participant.destroy

    respond_to do |format|
      format.html { redirect_to military_battle_participants_url }
      format.json { head :ok }
    end
  end
end
