class Military::BattleParticipantResultsController < ApplicationController
  # GET /military/battle_participant_results
  # GET /military/battle_participant_results.json
  def index
    @military_battle_participant_results = Military::BattleParticipantResult.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @military_battle_participant_results }
    end
  end

  # GET /military/battle_participant_results/1
  # GET /military/battle_participant_results/1.json
  def show
    @military_battle_participant_result = Military::BattleParticipantResult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @military_battle_participant_result }
    end
  end

  # GET /military/battle_participant_results/new
  # GET /military/battle_participant_results/new.json
  def new
    @military_battle_participant_result = Military::BattleParticipantResult.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @military_battle_participant_result }
    end
  end

  # GET /military/battle_participant_results/1/edit
  def edit
    @military_battle_participant_result = Military::BattleParticipantResult.find(params[:id])
  end

  # POST /military/battle_participant_results
  # POST /military/battle_participant_results.json
  def create
    @military_battle_participant_result = Military::BattleParticipantResult.new(params[:military_battle_participant_result])

    respond_to do |format|
      if @military_battle_participant_result.save
        format.html { redirect_to @military_battle_participant_result, notice: 'Battle participant result was successfully created.' }
        format.json { render json: @military_battle_participant_result, status: :created, location: @military_battle_participant_result }
      else
        format.html { render action: "new" }
        format.json { render json: @military_battle_participant_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /military/battle_participant_results/1
  # PUT /military/battle_participant_results/1.json
  def update
    @military_battle_participant_result = Military::BattleParticipantResult.find(params[:id])

    respond_to do |format|
      if @military_battle_participant_result.update_attributes(params[:military_battle_participant_result])
        format.html { redirect_to @military_battle_participant_result, notice: 'Battle participant result was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @military_battle_participant_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /military/battle_participant_results/1
  # DELETE /military/battle_participant_results/1.json
  def destroy
    @military_battle_participant_result = Military::BattleParticipantResult.find(params[:id])
    @military_battle_participant_result.destroy

    respond_to do |format|
      format.html { redirect_to military_battle_participant_results_url }
      format.json { head :ok }
    end
  end
end
