class Action::Military::AttackArmyActionsController < ApplicationController

  # GET /action/military/attack_army_actions/new
  # GET /action/military/attack_army_actions/new.json
  def new
    respond_to do |format|
      format.json { render json: { :attacker_id => nil, :defender_id => nil} }
    end
  end

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create
    attacker = Military::Army.find(params[:action_military_attack_army_action][:attacker_id])
    defender = Military::Army.find(params[:action_military_attack_army_action][:defender_id])
    
    raise ForbiddenError.new('tried to attack army in different location') unless attacker.location_id == defender.location_id

    raise ForbiddenError.new('tried to attack with foreign army') unless attacker.owner_id == current_character_id 

    raise ForbiddenError.new('tried to attack own army') unless attacker.owner_id != defender.owner_id

    raise ForbiddenError.new('not enough action points for attack') unless attacker.ap_present > 0

    raise ForbiddenError.new('attacker is already moving or battling') unless attacker.mode == 0 || attacker.battle_id.nil?

    battle = Military::Battle.start_fight_between(attacker, defender)    
    
    respond_to do |format|
      if battle
        format.json { render json: {}, status: :ok }
      else
        format.json { render json: {:error => 'error'}, status: :unprocessable_entity }
      end
    end
  end
end
