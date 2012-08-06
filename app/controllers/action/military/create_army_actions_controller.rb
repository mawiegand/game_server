class Action::Military::CreateArmyActionsController < ApplicationController
  layout 'action'
  
  before_filter :authenticate

  # POST /action/military/create_army_actions
  # POST /action/military/create_army_actions.json
  def create
    @action = params[:action_military_create_army_action]
    
    location = Map::Location.find(@action[:location_id])
    garrison_army = location.garrison_army

    raise BadRequestError.new('no garrison at location') if garrison_army.nil?    
    raise BadRequestError.new('not owner of location') unless location.owner == current_character
    raise BadRequestError.new('not owner of garrison') unless garrison_army.owner == current_character
    raise ForbiddenError.new('garrison is not idle')   unless garrison_army.mode == Military::Army::MODE_IDLE
    raise ForbiddenError.new('garrison is fighting')   unless garrison_army.battle_id.nil?
    
    GameRules::Rules.the_rules.unit_types.each do | unit_type |
      if !@action[unit_type[:db_field]].nil? && @action[unit_type[:db_field]].to_i < 0
        raise BadRequestError.new('negative unit quantity')
      end
    end
    
    raise BadRequestError.new('not enough units in army') unless garrison_army.contains?(@action)
    raise BadRequestError.new('not enough command points') unless location.settlement.command_points_available?
    garrison_army.reduce_units(@action)
    Military::Army.create_with_action(@action)

    respond_to do |format|
      format.html { redirect_to action_path, notice: 'Move army action was successfully executed.' }
      format.json { render json: {}, status: :created }
    end
  end
end
