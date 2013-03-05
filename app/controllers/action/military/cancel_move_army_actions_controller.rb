class Action::Military::CancelMoveArmyActionsController < ApplicationController
  layout 'action'
  
  before_filter :authenticate


  # GET /action/military/move_army_actions/new
  # GET /action/military/move_army_actions/new.json
  def new
    respond_to do |format|
      format.json { render json: { :army_id => nil} }
    end
  end

  # POST /action/military/move_army_actions
  # POST /action/military/move_army_actions.json
  def create
    army = Military::Army.find_by_id(params[:action_military_cancel_move_army_action][:army_id])
    raise BadRequestError.new('army does not exist') if army.blank?
    raise BadRequestError.new('no movement command found') if army.movement_command.blank?
    
    role = army.owned_by?(current_character_id) ? :owner : :character # TODO: staff / admin
    
    raise ForbiddenError.new('tried to cancel command of foreign army') unless role === :owner || role === :staff || role === :admin
    
    if army.movement_command.event.blank?   # don't crash, a cancel action might be the cure for a missing entry in the event table
      logger.error "Could not find an event for movement command #{army.movement_command.id}: " + army.movement_command.inspect + ' / ' + army.inspect
    else 
      army.movement_command.event.destroy
    end
    army.movement_command.destroy
    
    army.target_location_id = nil
    army.target_region_id = nil
    if army.mode === Military::Army::MODE_MOVING  # 1: moving?
      army.mode = Military::Army::MODE_IDLE
    end
    army.target_reached_at = nil  

    if !army.save 
      raise BadRequestError.new('could not save the new state of the army')
    end

    respond_to do |format|
      format.html { redirect_to new_action_military_cancel_move_army_action_path, notice: 'Move army action was successfully executed.' }
      format.json { render json: {}, status: :created }
    end
  end
  
end
