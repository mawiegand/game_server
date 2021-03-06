class Action::Military::ChangeArmyActionsController < ApplicationController
  layout 'action'
  
  before_filter :authenticate

  # POST /action/military/create_army_actions
  # POST /action/military/create_army_actions.json
  def create
    @action = params[:action_military_change_army_action]
    
    location = Map::Location.find(@action[:location_id])
    raise BadRequestError.new('location not found') if location.nil?
    raise BadRequestError.new('not owner of garrison army') unless location.owner == current_character

    garrison_army = location.garrison_army
    raise BadRequestError.new('garrison army not found') if garrison_army.nil?
    raise BadRequestError.new('not owner of garrison army') unless garrison_army.owner == current_character
    
    visible_army = Military::Army.find(@action[:visible_army_id])
    raise BadRequestError.new('army at settlement not found') if visible_army.nil?
    raise BadRequestError.new('not owner of visible army') unless visible_army.owner == current_character

    raise BadRequestError.new('settlement at location is not home of army') unless visible_army.home == location.settlement

    raise ForbiddenError.new('garrison is not idle')   unless garrison_army.mode == Military::Army::MODE_IDLE
    raise ForbiddenError.new('garrison is fighting')   unless garrison_army.battle_id.nil?

    raise ForbiddenError.new('army is not idle')   unless visible_army.mode == Military::Army::MODE_IDLE
    raise ForbiddenError.new('army is fighting')   unless visible_army.battle_id.nil?
    
    raise ForbiddenError.new('army is not at location of garrison')   unless visible_army.location_id == garrison_army.location_id

    
    units_to_add = {}
    units_to_reduce = {}
    
    unit_sum_to_add = 0
        
    GameRules::Rules.the_rules.unit_types.each do | unit_type |
      quantity = @action[unit_type[:db_field]].to_i      
      if quantity > 0
        units_to_add[unit_type[:db_field]] = quantity
      elsif quantity < 0
        units_to_reduce[unit_type[:db_field]] = -quantity
      end
      unit_sum_to_add += quantity
    end
    
    raise BadRequestError.new('not enough units in visible army') unless visible_army.contains?(units_to_reduce)
    raise BadRequestError.new('not enough units in garrison army') unless garrison_army.contains?(units_to_add)
    
    raise BadRequestError.new('not enough space in visible army') unless visible_army.can_receive?(unit_sum_to_add)    
    raise BadRequestError.new('not enough space in garrison army') unless garrison_army.can_receive?(-unit_sum_to_add)
    
    Military::Army.transaction do
      garrison_army.reduce_units(@action)
      visible_army.add_units(@action)
    end
    
    visible_army.destroy if visible_army.empty?

    respond_to do |format|
      format.html { redirect_to action_path, notice: 'Change army action was successfully executed.' }
      format.json { render json: {}, status: :created }
    end
  end
end
