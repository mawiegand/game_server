class Military::Battle < ActiveRecord::Base
  
  has_one    :event,        :class_name => "Event::Event",            :foreign_key => "local_event_id", :conditions => "event_type = 'military_battle'"

  has_many   :participants, :class_name => "Military::BattleParticipant", :foreign_key => "battle_id", :inverse_of => :battle, :dependent => :destroy
  has_many   :factions,     :class_name => "Military::BattleFaction", :foreign_key => "battle_id",     :inverse_of => :battle, :dependent => :destroy
  has_many   :rounds,       :class_name => "Military::BattleRound",   :foreign_key => "battle_id",     :inverse_of => :battle, :dependent => :destroy
  has_many   :armies,       :class_name => "Military::Army",          :foreign_key => "battle_id",     :inverse_of => :battle, :dependent => :destroy

  has_many   :participant_results, :class_name => "Military::BattleParticipantResult", :foreign_key => "battle_id", :inverse_of => :battle, :dependent => :destroy
  has_many   :faction_results,     :class_name => "Military::BattleFactionResult", :foreign_key => "battle_id",     :inverse_of => :battle, :dependent => :destroy

  belongs_to :initiator,    :class_name => "Fundamental::Character",  :foreign_key => "initiator_id"
  belongs_to :opponent,     :class_name => "Fundamental::Character",  :foreign_key => "opponent_id"
  
  belongs_to :region,       :class_name => "Map::Region",             :foreign_key => "region_id",     :inverse_of => :battles
  belongs_to :location,     :class_name => "Map::Location",           :foreign_key => "location_id",   :inverse_of => :battles
  
  
  # starts a fight between two armies. if one of the armies is already 
  # involved in an ongoing battle, the other is added to the opposing
  # faction.
  def self.start_fight_between(attacker, defender)
    raise ArgumentError.new('both armies are already fighting') if !attacker.battle_id.nil? && !defender.battle_id.nil?
    raise ArgumentError.new('armies NOT at same location') unless attacker.location_id == defender.location_id
    
    battle = nil
    
    if (!attacker.battle_id.nil? && attacker.battle_id > 0)      # A) add defender to attacker's battle
      battle = attacker.battle
      battle.add_army(defender, battle.other_faction(attacker.battle_participant.faction_id))
    elsif (!defender.battle_id.nil? && defender.battle_id > 0)   # B) add attacker to defender's battle
      battle = defender.battle
      battle.add_army(attacker, battle.other_faction(defender.battle_participant.faction_id))
    elsif attacker.able_to_overrun?(defender)                    # C) 
      self.overrun(attacker, defender)
    elsif defender.able_to_overrun?(attacker)                    # D)
      self.overrun(defender, attacker)
    else                                                         # E) create new battle (not involved, yet)
      battle = Military::Battle.create_battle_between(attacker, defender)
      battle.create_event_for_next_round
    end
    
    return battle
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

    attacker.kills += killed_units               # add kills
    attacker.save
    # create message

    # defender:
    Military::Army.destroy(defender.id)
    # create message
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
    attacker.battle = battle
    defender.battle = battle
    attacker.save
    defender.save
    
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

  #advanced the next_round_at field
  def schedule_next_round
    rules = GameRules::Rules.the_rules
    self.next_round_at.advance(:seconds => rules.battle[:calculation][:round_time] * GAME_SERVER_CONFIG['base_time_factor'])
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
    puts "HERE"
    puts     self.factions.where("id != ?", id).inspect
    puts self.factions.inspect
    
    self.factions.where("id != ?", id)
  end
  
  def other_faction(id)
    other_factions(id).first
  end
  
  def add_army(army, faction)
    faction.participants.create(:battle_id => faction.battle_id, :army_id => army.id,
                                :joined_at => DateTime.now, :retreated => false)
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

  #returns the a settlement if there was an battle over one
  def targeted_settlement
    participants.each do |participant|
      if participant.army.garrison
        return participant.army.home
      end
    end
    nil
  end

end
