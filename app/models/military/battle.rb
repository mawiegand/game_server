class Military::Battle < ActiveRecord::Base
  
  has_one    :event,        :class_name => "Event::Event",                :foreign_key => "local_event_id", :conditions => "event_type = 'military_battle'"

  has_many   :participants, :class_name => "Military::BattleParticipant", :foreign_key => "battle_id",      :inverse_of => :battle, :dependent => :destroy
  has_many   :factions,     :class_name => "Military::BattleFaction",     :foreign_key => "battle_id",      :inverse_of => :battle, :dependent => :destroy, :order => 'id ASC'
  has_many   :rounds,       :class_name => "Military::BattleRound",       :foreign_key => "battle_id",      :inverse_of => :battle, :dependent => :destroy, :order => 'round_num ASC'
  has_many   :armies,       :class_name => "Military::Army",              :foreign_key => "battle_id",      :inverse_of => :battle

  has_many   :participant_results, :class_name => "Military::BattleParticipantResult", :foreign_key => "battle_id", :inverse_of => :battle, :dependent => :destroy
  has_many   :faction_results,     :class_name => "Military::BattleFactionResult",     :foreign_key => "battle_id", :inverse_of => :battle, :dependent => :destroy
  has_many   :character_results,   :class_name => "Military::BattleCharacterResult",   :foreign_key => "battle_id", :inverse_of => :battle

  belongs_to :initiator,    :class_name => "Fundamental::Character",      :foreign_key => "initiator_id"
  belongs_to :opponent,     :class_name => "Fundamental::Character",      :foreign_key => "opponent_id"
  
  belongs_to :region,       :class_name => "Map::Region",                 :foreign_key => "region_id",      :inverse_of => :battles
  belongs_to :location,     :class_name => "Map::Location",               :foreign_key => "location_id",    :inverse_of => :battles
  
  belongs_to :message,      :class_name => "Messaging::Message",          :foreign_key => "message_id"
  
  
  after_save :destroy_dependent_models_on_remove
  
  # starts a fight between two armies. if one of the armies is already 
  # involved in an ongoing battle, the other is added to the opposing
  # faction.
  def self.start_fight_between(attacker, defender)
    raise ArgumentError.new('armies NOT at same location') unless attacker.location_id == defender.location_id
    
    battle = nil
    
    #remove a runnung movement command from both attacker and defender
    # TODO: this allows spam-attacks on armies. Halt movement, but don't cancel it
    if attacker.moving?
      attacker.delete_movement
    end
    
    if defender.moving?
      defender.delete_movement
    end
    
    if attacker.fighting? && defender.fighting?                  # merge fights
      raise ArgumentError.new('attacking army is not garrison army')             unless attacker.garrison
      raise ArgumentError.new('armies are already fighting in the same battle')  if attacker.battle == defender.battle
      self.merge_battles(attacker, defender)
      attacker.battle.add_fortress_defenders(attacker, defender, true, true)
    elsif attacker.fighting?                                     # add defender to attacker's battle
      battle = attacker.battle
      battle.add_army(defender, battle.other_faction(attacker.battle_participant.faction_id))
      battle.add_fortress_defenders(attacker, defender, true, false)
      self.send_attack_notification_if_necessary_to(defender, attacker)      
    elsif defender.fighting?                                     # B) add attacker to defender's battle
      battle = defender.battle
      battle.add_army(attacker, battle.other_faction(defender.battle_participant.faction_id))
      battle.add_fortress_defenders(attacker, defender, false, true)
    elsif attacker.able_to_overrun?(defender)                    # C) 
      self.overrun(attacker, defender)
      self.send_attack_notification_if_necessary_to(defender, attacker)
    elsif defender.able_to_overrun?(attacker)                    # D)
      self.overrun(defender, attacker)
      self.send_attack_notification_if_necessary_to(defender, attacker)
    else                                                         # E) create new battle (not involved, yet)
      battle = Military::Battle.create_battle_between(attacker, defender)
      battle.add_fortress_defenders(attacker, defender, false, false)
      battle.create_event_for_next_round
      self.send_attack_notification_if_necessary_to(defender, attacker)
    end
    
    return battle
  end
  
  def self.merge_battles(attacker, defender)
    # end current battle of defender
    defender.battle.ended_at = Time.now
    defender.battle.save

    # send notification messages for participants of ending battle
    defender.battle.generate_messages_for_battle(nil, defender.battle)
        
    # put participants of defender's faction in defender's battle to the faction of attacker's opponents in attacker's battle
    defender.battle_participant.faction.participants.each do |participant|
      
      logger.debug "new battle: #{participant.battle.id}, old battle: #{defender.battle.id}, new faction: #{participant.faction.id}, old faction: #{attacker.battle_participant.faction.opposing_faction.id}"
      
      if participant.army.nil? || participant.army.empty?
        logger.debug "don't add the above army because it is already dead."
      else
        attacker.battle.add_army(participant.army, attacker.battle.other_faction(attacker.battle_participant.faction_id))
      end
    end
    
    # put participants of defender's opposing faction in defender's battle to attacker's faction in attacker's battle
    defender.battle_participant.faction.opposing_faction.participants.each do |participant|
      
      logger.debug "new battle: #{participant.battle.id}, old battle: #{defender.battle.id}, new faction: #{participant.faction.id}, old faction: #{attacker.battle_participant.faction.id}"
      
      if participant.army.nil? || participant.army.empty?
        logger.debug "don't add the above army because it is already dead."
      else
        attacker.battle.add_army(participant.army, attacker.battle_participant.faction)
      end      
    end
    
    attacker.battle.save
    
    # cleanup defenders battle
    ## cleanup of the destroyed armies and the battle object
    defender.battle.cleanup
  end
  
  #deletes armies that no longer exists (or marks them as removed)
  def cleanup
    # delete participating armies
    self.armies.each do |army|
      if (army.empty? && !army.garrison?)
        if GAME_SERVER_CONFIG['military_only_flag_destroyed_armies']
          army.removed = true
          if !army.save
            raise InternalServerError.new('Failed to flag an army as removed')
          end
        else
          army.destroy
        end
      end
    end

    # destroy appropriate event
    self.event.destroy
    
    # remove battle or set to removed
    if GAME_SERVER_CONFIG['military_only_flag_destroyed_battles']
      self.removed = true
      if !self.save
        raise InternalServerError.new('Failed to flag an battle as removed')
      end
    else
      self.destroy
    end
  end
  
  # add armies with stance 'defending fortress' to garrison fraction of battle
  def add_fortress_defenders(attacker, defender, attacker_fighting, defender_fighting)
    if attacker.location.fortress?                                               # attacker.location == defender.location
      if attacker.garrison                                                       # if attacker is garrison army 
        attacker.location.armies.each do |other_army|                            # add all defending armies
          if (other_army != attacker &&                                          # don't add attacker
              other_army != defender &&                                          # or defender, they are already involved
              !other_army.fighting? &&                                           # only add non fighting armies
              !defender.battle_participant.faction.contains_army_of(other_army.owner) &&   # don't let armies of current character defend his own attack
              other_army.defending?)                                             # only add armies with appropriate stance            
            other_army.delete_movement if other_army.moving?                     # delete movement of newly added army
            self.add_army(other_army, attacker.battle_participant.faction)
          end
        end                                                                      
      elsif (defender.garrison ||                                                # if defender is garrison army
             defender.battle_participant.faction.contains_garrison?)             # or a fighting army in garrison faction
        defender.location.armies.each do |other_army|                            # add all defending armies
          if (other_army != attacker &&                                          # don't add attacker
              other_army != defender &&                                          # or defender, they are already involved
              !other_army.fighting? &&                                           # only add non fighting armies
              !attacker.battle_participant.faction.contains_army_of(other_army.owner) &&  # don't let armies of current character defend his own attack
              (other_army.defending? || other_army.garrison))                    # only add armies with appropriate stance, always add garrison 
            other_army.delete_movement if other_army.moving?                     # delete movement of newly added army
            self.add_army(other_army, defender.battle_participant.faction)
            Military::Battle.send_attack_notification_if_necessary_to(other_army, attacker)
          end
        end
      elsif (defender.defending? && !defender_fighting &&                        # if defender is a non fighting defending army
          defender.same_alliance_as?(defender.location))                         # and if defender is in the same alliance as the fortress garrison army
        defender.location.armies.each do |other_army|                            # add all defending armies
          if (other_army != attacker &&                                          # don't add attacker
              other_army != defender &&                                          # or defender, they are already involved
              !other_army.fighting? &&                                           # only add non fighting armies
              !attacker.battle_participant.faction.contains_army_of(other_army.owner) &&  # don't let armies of current character defend his own attack
              (other_army.defending? || other_army.garrison))                    # only add armies with appropriate stance, always add garrison 
            other_army.delete_movement if other_army.moving?                     # delete movement of newly added army
            self.add_army(other_army, defender.battle_participant.faction)
            Military::Battle.send_attack_notification_if_necessary_to(other_army, attacker)
          end
        end
      end
    end
  end
  
  def self.overrun(attacker, defender)
    # attacker
    attacker.victories += 1            # add victory

    killed_units = 0                   # calculate number of killed units
    GameRules::Rules.the_rules.unit_types.each do |unit_type|
      if !defender.details[unit_type[:db_field]].nil? && defender.details[unit_type[:db_field]] > 0
        killed_units += defender.details[unit_type[:db_field]]
      end
    end

    attacker.kills += killed_units     # add kills
    attacker.save

    # create message for winner and loser
    Messaging::Message.generate_overrun_winner_message(attacker, defender)
    Messaging::Message.generate_overrun_loser_message(attacker, defender) 

    Military::Army.destroy(defender.id)
  end
  
  def self.create_battle_between(attacker, defender)
    rules = GameRules::Rules.the_rules

    battle = Military::Battle.create(
      :started_at => DateTime.now,
      :next_round_at => DateTime.now.advance(:seconds => rules.battle[:calculation][:round_time] * GAME_SERVER_CONFIG['base_time_factor']), #DateTime.now.advance(:seconds => 60 * 30 ),   # CONFIG
      :initiator_id => attacker.owner_id,
      :opponent_id => defender.owner_id,
      :location_id => attacker.location_id,
      :region_id => attacker.region_id
    )
    
    faction0 = battle.factions.create(
      :faction_num => 0,
      :leader_id => attacker.owner_id,
      :joined_at => DateTime.now)
      
    faction1 = battle.factions.create(
      :faction_num => 1,
      :leader_id => defender.owner_id,
      :joined_at => DateTime.now)
      
    battle.add_army(attacker, faction0)
    battle.add_army(defender, faction1)
    
    #add defenders of garrison, if necessary
    battle
  end
  
  def self.send_attack_notification_if_necessary_to(defender, attacker)
    if !defender.owner.npc? && defender.owner.offline? && defender.owner.platinum_account?
      ip_access = IdentityProvider::Access.new(
        identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
        game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
        scopes:                     ['5dentity'],
      )
      ip_access.deliver_attack_notification(defender.owner, defender, attacker.owner)
    end    
  end

  #advanced the next_round_at field
  def schedule_next_round
    rules = GameRules::Rules.the_rules
    self.next_round_at = self.next_round_at.advance(:seconds => rules.battle[:calculation][:round_time] * GAME_SERVER_CONFIG['base_time_factor'])
  end
  
  def create_event_for_next_round
    #create entry for event table
    event = Event::Event.new(
        character_id: self.initiator_id,
        execute_at: self.next_round_at,
        event_type: "military_battle",
        local_event_id: self.id,
    )
    if !event.save # this is the final step; this makes sure, something is actually executed
      raise ArgumentError.new('could not create event')
    end
  end

  def other_factions(id)
    self.factions.where("id != ?", id)
  end
  
  def other_faction(id)
    other_factions(id).first
  end
  
  def add_army(army, faction)
    logger.debug "Adding army #{army.id}: #{army} to faction #{faction.id}: #{faction}."
    army.battle = self
    army.save
    faction.participants.create({
      battle_id: faction.battle_id,
      character_id: army.owner_id,
      army_id: army.id,
      joined_at: DateTime.now,
      retreated: false
    })
    faction.update_from_participants
  end
  
  def battle_done?
    active_factions = 0
    factions.each do |f|
      logger.debug("f.has_units_fighting? = "+f.has_units_fighting?.to_s)
      active_factions += 1 if f.has_units_fighting?
    end
    return !(active_factions > 1)
  end

  #@pre battle_done? == true
  def winner_faction
    result = nil
    self.factions.each do |faction|
      if faction.has_units_fighting?
        raise InternalServerError.new('There were more than one factions that still had units fighting even though the fight should be over') unless result.nil?
        result = faction
      end
    end
    result
  end
  
  def loser_faction
    other_faction(winner_faction.id)
  end
  
  def xp_for_character_and_faction(character, faction)
    character_result = self.character_results.where(['character_id = ? and faction_id = ?', character.id, faction.id]).first
    character_result.nil? ? 0 : character_result.experience_gained
  end

  #returns the a settlement if there was an battle over one
  def targeted_settlement
    participants.each do |participant|
      if !participant.disbanded? && !participant.army.nil? && participant.army.garrison
        return participant.army.home
      end
    end
    nil
  end
  
  ################################################################################
  #
  #  experience points
  #
  ################################################################################
  
  def calculate_character_results
    winner_units_count = 0
    winner_faction.participants.each do |participant|
      winner_units_count += participant.results.first.units_count unless participant.results.empty?
    end
    
    loser_units_count = 0
    loser_faction.participants.each do |participant|
      loser_units_count += participant.results.first.units_count unless participant.results.empty?
    end
    
    logger.debug "winner_units: #{winner_units_count}, loser_units_count #{loser_units_count}, rounds.count #{rounds.count}"
    
    # winner faction: calculate winner experience according to new function
    winner_faction.participants.each do |participant|
      unless participant.results.empty?
        character_result = Military::BattleCharacterResult.find_or_initialize_by_character_id_and_faction_id_and_battle_id(participant.character_id, participant.faction_id, self.id)
        character_result.experience_gained += (2.0 * participant.num_rounds / rounds.count * participant.results.first.units_count * (loser_units_count ** 2) / (winner_units_count ** 2)).to_i
        logger.debug "participant.num_rounds #{participant.num_rounds}, participant.army.units_count #{participant.results.first.units_count}, loser_units_count: #{loser_units_count}, winner_units_count: #{winner_units_count}"
        character_result.winner = true
        character_result.save
      end
    end
  end
  
  def propagate_character_results_to_character
    self.character_results.each do |result|
      logger.debug "propagate_character_results_to_character: add #{result.experience_gained} to character id #{result.character.id}"
      result.character.add_experience(result.experience_gained)
    end
  end
  
  def count_victory_and_defeat
    winner_faction.count_victory
    loser_faction.count_defeat
  end
  
  protected
    
    def destroy_dependent_models
      self.participants.destroy_all
      self.factions.destroy_all
      self.rounds.destroy_all
      
      self.participant_results.destroy_all
      self.faction_results.destroy_all        
    end
    
    def destroy_dependent_models_on_remove
      if !self.changes[:removed].blank? && self.changes[:removed][1] == true
        logger.debug "Battle #{self.id} was removed. Now starting to destroy dependent models."
        self.destroy_dependent_models
        logger.debug "Finished destroying dependent models."
      end
      true
    end
end
