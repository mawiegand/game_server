class Military::BattleFactionResultsController < ApplicationController
  layout 'military'
  
  before_filter :authenticate


  # GET /military/battle_faction_results
  # GET /military/battle_faction_results.json
  def index
    @military_battle_faction_results = Military::BattleFactionResult.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @military_battle_faction_results }
    end
  end

  # GET /military/battle_faction_results/1
  # GET /military/battle_faction_results/1.json
  def show
    @military_battle_faction_result = Military::BattleFactionResult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @military_battle_faction_result }
    end
  end

  # GET /military/battle_faction_results/new
  # GET /military/battle_faction_results/new.json
  def new
    @military_battle_faction_result = Military::BattleFactionResult.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @military_battle_faction_result }
    end
  end

  # GET /military/battle_faction_results/1/edit
  def edit
    @military_battle_faction_result = Military::BattleFactionResult.find(params[:id])
  end

  # POST /military/battle_faction_results
  # POST /military/battle_faction_results.json
  def create
    @military_battle_faction_result = Military::BattleFactionResult.new(params[:military_battle_faction_result])

    respond_to do |format|
      if @military_battle_faction_result.save
        format.html { redirect_to @military_battle_faction_result, notice: 'Battle faction result was successfully created.' }
        format.json { render json: @military_battle_faction_result, status: :created, location: @military_battle_faction_result }
      else
        format.html { render action: "new" }
        format.json { render json: @military_battle_faction_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /military/battle_faction_results/1
  # PUT /military/battle_faction_results/1.json
  def update
    @military_battle_faction_result = Military::BattleFactionResult.find(params[:id])

    respond_to do |format|
      if @military_battle_faction_result.update_attributes(params[:military_battle_faction_result])
        format.html { redirect_to @military_battle_faction_result, notice: 'Battle faction result was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @military_battle_faction_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /military/battle_faction_results/1
  # DELETE /military/battle_faction_results/1.json
  def destroy
    @military_battle_faction_result = Military::BattleFactionResult.find(params[:id])
    @military_battle_faction_result.destroy

    respond_to do |format|
      format.html { redirect_to military_battle_faction_results_url }
      format.json { head :ok }
    end
  end
end
