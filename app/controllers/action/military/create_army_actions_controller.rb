class Action::Military::CreateArmyActionsController < ApplicationController
  layout 'action'
  
  before_filter :authenticate

  # GET /action/military/create_army_actions
  # GET /action/military/create_army_actions.json
  def index
    @action_military_create_army_actions = Action::Military::CreateArmyAction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @action_military_create_army_actions }
    end
  end

  # GET /action/military/create_army_actions/1
  # GET /action/military/create_army_actions/1.json
  def show
    @action_military_create_army_action = Action::Military::CreateArmyAction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @action_military_create_army_action }
    end
  end

  # GET /action/military/create_army_actions/new
  # GET /action/military/create_army_actions/new.json
  def new
    @action_military_create_army_action = Action::Military::CreateArmyAction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @action_military_create_army_action }
    end
  end

  # GET /action/military/create_army_actions/1/edit
  def edit
    @action_military_create_army_action = Action::Military::CreateArmyAction.find(params[:id])
  end

  # POST /action/military/create_army_actions
  # POST /action/military/create_army_actions.json
  def create
    @action = params[:action_military_create_army_action]
    
    location = Map::Location.find(@action[:location_id])
    garrison_army = location.garrison_army
    logger.debug '---> garrison_army ' + garrison_army.inspect
    
    # TODO owner testen
    
    if garrison_army.contains?(@action)
      garrison_army.reduce_units(@action)
      Military::Army.create_with_action(@action)
    end

    respond_to do |format|
      format.html { redirect_to action_path, notice: 'Move army action was successfully executed.' }
      format.json { render json: {}, status: :created }
    end
  end
  

  # PUT /action/military/create_army_actions/1
  # PUT /action/military/create_army_actions/1.json
  def update
    @action_military_create_army_action = Action::Military::CreateArmyAction.find(params[:id])

    respond_to do |format|
      if @action_military_create_army_action.update_attributes(params[:action_military_create_army_action])
        format.html { redirect_to @action_military_create_army_action, notice: 'Create army action was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @action_military_create_army_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /action/military/create_army_actions/1
  # DELETE /action/military/create_army_actions/1.json
  def destroy
    @action_military_create_army_action = Action::Military::CreateArmyAction.find(params[:id])
    @action_military_create_army_action.destroy

    respond_to do |format|
      format.html { redirect_to action_military_create_army_actions_url }
      format.json { head :ok }
    end
  end
end
