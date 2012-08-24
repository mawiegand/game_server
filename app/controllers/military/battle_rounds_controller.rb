class Military::BattleRoundsController < ApplicationController
  layout 'military'
  
  before_filter :authenticate

  # GET /military/battle_rounds
  # GET /military/battle_rounds.json
  def index
    @military_battle_rounds = Military::BattleRound.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @military_battle_rounds }
    end
  end

  # GET /military/battle_rounds/1
  # GET /military/battle_rounds/1.json
  def show
    @military_battle_round = Military::BattleRound.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @military_battle_round }
    end
  end

  # GET /military/battle_rounds/new
  # GET /military/battle_rounds/new.json
  def new
    @military_battle_round = Military::BattleRound.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @military_battle_round }
    end
  end

  # GET /military/battle_rounds/1/edit
  def edit
    @military_battle_round = Military::BattleRound.find(params[:id])
  end

  # POST /military/battle_rounds
  # POST /military/battle_rounds.json
  def create
    @military_battle_round = Military::BattleRound.new(params[:military_battle_round])

    respond_to do |format|
      if @military_battle_round.save
        format.html { redirect_to @military_battle_round, notice: 'Battle round was successfully created.' }
        format.json { render json: @military_battle_round, status: :created, location: @military_battle_round }
      else
        format.html { render action: "new" }
        format.json { render json: @military_battle_round.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /military/battle_rounds/1
  # PUT /military/battle_rounds/1.json
  def update
    @military_battle_round = Military::BattleRound.find(params[:id])

    respond_to do |format|
      if @military_battle_round.update_attributes(params[:military_battle_round])
        format.html { redirect_to @military_battle_round, notice: 'Battle round was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @military_battle_round.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /military/battle_rounds/1
  # DELETE /military/battle_rounds/1.json
  def destroy
    @military_battle_round = Military::BattleRound.find(params[:id])
    @military_battle_round.destroy

    respond_to do |format|
      format.html { redirect_to military_battle_rounds_url }
      format.json { head :ok }
    end
  end
end
