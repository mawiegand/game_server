class Action::Military::CreateArmyActionsController < ApplicationController
  layout 'action'
  
  before_filter :authenticate

  # POST /action/military/create_army_actions
  # POST /action/military/create_army_actions.json
  def create
    @action = params[:action_military_create_army_action]
    
    location = Map::Location.find(@action[:location_id])
    garrison_army = location.garrison_army
    
    raise BadRequestError.new('not owner of location') unless location.owner == current_character
    
    # TODO Werte auf > 0 testen
    
    raise BadRequestError.new('not enough units in army') unless garrison_army.contains?(@action)
    garrison_army.reduce_units(@action)
    Military::Army.create_with_action(@action)

    respond_to do |format|
      format.html { redirect_to action_path, notice: 'Move army action was successfully executed.' }
      format.json { render json: {}, status: :created }
    end
  end
end
