class Action::Military::MoveArmyActionsController < ApplicationController
  # GET /action/military/move_army_actions
  # GET /action/military/move_army_actions.json
  def index
    @action_military_move_army_actions = Action::Military::MoveArmyAction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @action_military_move_army_actions }
    end
  end

  # GET /action/military/move_army_actions/1
  # GET /action/military/move_army_actions/1.json
  def show
    @action_military_move_army_action = Action::Military::MoveArmyAction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @action_military_move_army_action }
    end
  end

  # GET /action/military/move_army_actions/new
  # GET /action/military/move_army_actions/new.json
  def new
    @action_military_move_army_action = Action::Military::MoveArmyAction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @action_military_move_army_action }
    end
  end

  # GET /action/military/move_army_actions/1/edit
  def edit
    @action_military_move_army_action = Action::Military::MoveArmyAction.find(params[:id])
  end

  # POST /action/military/move_army_actions
  # POST /action/military/move_army_actions.json
  def create
    @action_military_move_army_action = Action::Military::MoveArmyAction.new(params[:action_military_move_army_action])
    army = @action_military_move_army_action.army
    @action_military_move_army_action.starting_location_id = army.location_id
    @action_military_move_army_action.starting_region_id = army.region_id
    
    # now fetch and fill the target region id
    target_location = @action_military_move_army_action.target_location 
    raise BadRequestError.new('target location does not exist') if target_location.nil?
    @action_military_move_army_action.target_region_id = target_location.region_id
    
    
    # check whether this movement is possible and allowed (neighbouring positions, starts at present position, owned by current character)
    raise BadRequestError.new('army not found') if army.blank?
    raise BadRequestError.new('could not get army\'s current location') if @action_military_move_army_action.starting_location_id != army.location_id
    raise BadRequestError.new('could not get army\'s current region') if @action_military_move_army_action.starting_region_id != army.region_id
    if 1  # TODO: !admin
      raise ForbiddenError.new('tried to move army not owned by character') if !army.owned_by?(current_character_id)
    end
    
    respond_to do |format|
      if @action_military_move_army_action.save
        format.html { redirect_to @action_military_move_army_action, notice: 'Move army action was successfully created.' }
        format.json { render json: @action_military_move_army_action, status: :created, location: @action_military_move_army_action }
      else
        format.html { render action: "new" }
        format.json { render json: @action_military_move_army_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /action/military/move_army_actions/1
  # PUT /action/military/move_army_actions/1.json
  def update
    @action_military_move_army_action = Action::Military::MoveArmyAction.find(params[:id])

    respond_to do |format|
      if @action_military_move_army_action.update_attributes(params[:action_military_move_army_action])
        format.html { redirect_to @action_military_move_army_action, notice: 'Move army action was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @action_military_move_army_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /action/military/move_army_actions/1
  # DELETE /action/military/move_army_actions/1.json
  def destroy
    @action_military_move_army_action = Action::Military::MoveArmyAction.find(params[:id])
    @action_military_move_army_action.destroy

    respond_to do |format|
      format.html { redirect_to action_military_move_army_actions_url }
      format.json { head :ok }
    end
  end
end
