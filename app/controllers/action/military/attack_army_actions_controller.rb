class Action::Military::AttackArmyActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create
    Military::Army.transaction do  
      attacker = Military::Army.find(params[:action_military_attack_army_action][:attacker_id])
      defender = Military::Army.find(params[:action_military_attack_army_action][:defender_id])
      
      attacker.lock!
      defender.lock!
    
      raise ForbiddenError.new('tried to attack army in different location')    unless attacker.location_id == defender.location_id
      raise ForbiddenError.new('tried to attack with foreign army')             unless attacker.owner_id == current_character_id
      raise ForbiddenError.new('tried to attack own army')                      if attacker.owner_id == defender.owner_id
      raise ForbiddenError.new('attacker is already fighting')                  if attacker.fighting? && !attacker.garrison?  # garrison may attack another army! (presently, because there's no wegerecht)
      raise ForbiddenError.new('attacker army is empty')                        if attacker.empty?
      raise ForbiddenError.new('attacker is currently suspended')               if attacker.suspended?
      raise ForbiddenError.new('defender is currently under attack protection') if defender.protected?

      raise ConflictError.new('garrison is not allowed to attack poacher')     if attacker.garrison? && defender.is_poacher?
      raise ConflictError.new('tried to start or intervene a foreign poacher fight') if defender.is_foreign_poacher_of?(attacker.owner) || defender.is_fighting_against_poacher?
      raise ConflictError.new('tried to start poacher fight while attacker is already fighting') if attacker.fighting? && defender.is_poacher?

      attacker.consume_ap         unless attacker.garrison?                                    # raises a BadAccessError if no aps are available
      Military::Battle.start_fight_between(attacker, defender)     # creates and returns battle, or returns nil, if army was overrun
    end
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
end
