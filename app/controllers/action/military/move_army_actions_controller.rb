class Action::Military::MoveArmyActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate
  before_filter :deny_api, :except => [:show, :index, :create]
  
  
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
    raise BadRequestError.new('army not found') if army.blank?
    
    @action_military_move_army_action.starting_location_id = army.location_id
    @action_military_move_army_action.starting_region_id = army.region_id
    @action_military_move_army_action.sender_ip = request.remote_ip  #@remote_ip = request.env["HTTP_X_FORWARDED_FOR"]
    
    # now fetch and fill the target region id
    target_location = @action_military_move_army_action.target_location 
    raise BadRequestError.new('target location does not exist') if target_location.nil?
    @action_military_move_army_action.target_region_id = target_location.region_id
    
    # check whether this movement is possible and allowed (neighbouring positions, owned by current character)
    role = army.owned_by?(current_character_id) ? :owner : :character # TODO: staff / admin
    raise BadRequestError.new('Invalid action.') unless @action_military_move_army_action.valid_action?(role)
        
    @action_military_move_army_action.army.consume_ap(1)  # consume one action point
    @action_military_move_army_action.army.target_location_id = @action_military_move_army_action.target_location_id
    @action_military_move_army_action.army.target_region_id = @action_military_move_army_action.target_region_id
    @action_military_move_army_action.army.mode = Military::Army::MODE_MOVING # 1: moving?
    @action_military_move_army_action.army.target_reached_at = DateTime.now.advance(:seconds => GAME_SERVER_CONFIG['movement_duration'] * GAME_SERVER_CONFIG['base_time_factor']) # for first tests, should be 15 minutes in future

    if !@action_military_move_army_action.army.save  # save army first; better have no movement action than a movement action without the army being properly set (could result in second movement action)
      raise BadRequestError.new('could not modify army properly')
    end
    if !@action_military_move_army_action.save 
      raise BadRequestError.new('could not create movement action')
    end
    
    #create entry for event table
    event = Event::Event.new(
      character_id: current_character_id,
      execute_at: @action_military_move_army_action.army.target_reached_at,
      event_type: "action_military_move_army_action",
      local_event_id: @action_military_move_army_action.id,
    )
        
    if !event.save # this is the final step; this makes sure, something is actually executed
      raise BadRequestError.new('could not create event')
    end
        
    respond_to do |format|
      format.html { redirect_to @action_military_move_army_action, notice: 'Move army action was successfully created.' }
      format.json { render json: @action_military_move_army_action, status: :created, location: @action_military_move_army_action }
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
