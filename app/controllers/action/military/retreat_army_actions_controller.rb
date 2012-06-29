class Action::Military::RetreatArmyActionsController < ApplicationController
  layout 'action'
  
  before_filter :authenticate

  # POST /action/military/create_army_actions
  # POST /action/military/create_army_actions.json
  def create
    @action = params[:action_military_retreat_army_action]
    
    army = Military::Army.find(@action[:army_id])
    
    raise NotFoundError.new('army not found') if army.nil?
    raise BadRequestError.new('not owner of army') unless army.owner == current_character

    army.battle_retreat = @action[:retreat]
    raise BadRequestError.new('not owner of army') unless army.save    

    respond_to do |format|
      format.html { redirect_to action_path, notice: 'Retreat army action was successfully executed.' }
      format.json { render json: {}, status: :created }
    end
  end
  
end
