class Action::Military::AttackArmyActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create
    attacker = Military::Army.find(params[:action_military_attack_army_action][:attacker_id])
    defender = Military::Army.find(params[:action_military_attack_army_action][:defender_id])
    
    raise ForbiddenError.new('tried to attack army in different location') unless attacker.location_id == defender.location_id

    raise ForbiddenError.new('tried to attack with foreign army') unless attacker.owner_id == current_character_id 

    raise ForbiddenError.new('tried to attack own army') unless attacker.owner_id != defender.owner_id

    raise ForbiddenError.new('not enough action points for attack') unless attacker.ap_present > 0
    attacker.ap_present -= 1

    raise ForbiddenError.new('attacker is already moving or battling') unless attacker.mode === Military::Army::MODE_IDLE || attacker.battle_id.nil?

    Military::Battle.start_fight_between(attacker, defender)     # creates and returns battle, or returns nil, if army was overrun

    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
end
