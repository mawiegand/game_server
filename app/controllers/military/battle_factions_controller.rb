class Military::BattleFactionsController < ApplicationController
  layout 'military'
  
  before_filter :authenticate


  # GET /military/battle_factions
  # GET /military/battle_factions.json
  def index
    @military_battle_factions = Military::BattleFaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @military_battle_factions }
    end
  end

  # GET /military/battle_factions/1
  # GET /military/battle_factions/1.json
  def show
    @military_battle_faction = Military::BattleFaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @military_battle_faction }
    end
  end

  # GET /military/battle_factions/new
  # GET /military/battle_factions/new.json
  def new
    @military_battle_faction = Military::BattleFaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @military_battle_faction }
    end
  end

  # GET /military/battle_factions/1/edit
  def edit
    @military_battle_faction = Military::BattleFaction.find(params[:id])
  end

  # POST /military/battle_factions
  # POST /military/battle_factions.json
  def create
    @military_battle_faction = Military::BattleFaction.new(params[:military_battle_faction])

    respond_to do |format|
      if @military_battle_faction.save
        format.html { redirect_to @military_battle_faction, notice: 'Battle faction was successfully created.' }
        format.json { render json: @military_battle_faction, status: :created, location: @military_battle_faction }
      else
        format.html { render action: "new" }
        format.json { render json: @military_battle_faction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /military/battle_factions/1
  # PUT /military/battle_factions/1.json
  def update
    @military_battle_faction = Military::BattleFaction.find(params[:id])

    respond_to do |format|
      if @military_battle_faction.update_attributes(params[:military_battle_faction])
        format.html { redirect_to @military_battle_faction, notice: 'Battle faction was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @military_battle_faction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /military/battle_factions/1
  # DELETE /military/battle_factions/1.json
  def destroy
    @military_battle_faction = Military::BattleFaction.find(params[:id])
    @military_battle_faction.destroy

    respond_to do |format|
      format.html { redirect_to military_battle_factions_url }
      format.json { head :ok }
    end
  end
end
