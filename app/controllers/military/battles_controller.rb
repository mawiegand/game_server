class Military::BattlesController < ApplicationController
  layout 'military'

  # GET /military/battles
  # GET /military/battles.json
  def index
    @military_battles = Military::Battle.order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @military_battles }
    end
  end

  # GET /military/battles/1
  # GET /military/battles/1.json
  def show
    @military_battle = Military::Battle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @military_battle.to_json(:include => [:rounds, :factions, :participants, :armies]) }
    end
  end

  # GET /military/battles/new
  # GET /military/battles/new.json
  def new
    @military_battle = Military::Battle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @military_battle }
    end
  end

  # GET /military/battles/1/edit
  def edit
    @military_battle = Military::Battle.find(params[:id])
  end

  # POST /military/battles
  # POST /military/battles.json
  def create
    @military_battle = Military::Battle.new(params[:military_battle])

    respond_to do |format|
      if @military_battle.save
        format.html { redirect_to @military_battle, notice: 'Battle was successfully created.' }
        format.json { render json: @military_battle, status: :created, location: @military_battle }
      else
        format.html { render action: "new" }
        format.json { render json: @military_battle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /military/battles/1
  # PUT /military/battles/1.json
  def update
    @military_battle = Military::Battle.find(params[:id])

    respond_to do |format|
      if @military_battle.update_attributes(params[:military_battle])
        format.html { redirect_to @military_battle, notice: 'Battle was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @military_battle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /military/battles/1
  # DELETE /military/battles/1.json
  def destroy
    @military_battle = Military::Battle.find(params[:id])
    @military_battle.destroy

    respond_to do |format|
      format.html { redirect_to military_battles_url }
      format.json { head :ok }
    end
  end
end
