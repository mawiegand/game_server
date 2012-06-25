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
    
    units_to_add = {}
    units_to_reduce = {}
    
    GameRules::Rules.the_rules.unit_types.each do | unit_type |
      quantity = @action[unit_type[:db_field]].to_i      
      if quantity > 0
        units_to_add[unit_type[:db_field]] = quantity
      elsif quantity < 0
        units_to_reduce[unit_type[:db_field]] = -quantity
      end
    end
  
    raise BadRequestError.new('not enough units in garrison army') unless garrison_army.contains?(units_to_add)
    raise BadRequestError.new('not enough units in visible army') unless visible_army.contains?(units_to_reduce)
    
    # werte von g army abziehen
    garrison_army.reduce_units(@action)
    visible_army.add_units(@action)
    
    visible_army.destroy if visible_army.empty?

    respond_to do |format|
      format.html { redirect_to action_path, notice: 'Change army action was successfully executed.' }
      format.json { render json: {}, status: :created }
    end
  end
end
