class Military::Battle < ActiveRecord::Base
  
  has_one    :event,        :class_name => "Event::Event",            :foreign_key => "local_event_id"

  has_many   :participants, :class_name => "Military::BattleParticipant", :foreign_key => "battle_id", :inverse_of => :battle  
  has_many   :factions,     :class_name => "Military::BattleFaction", :foreign_key => "battle_id",     :inverse_of => :battle
  has_many   :rounds,       :class_name => "Military::BattleRound",   :foreign_key => "battle_id",     :inverse_of => :battle 
  has_many   :armies,       :class_name => "Military::Army",          :foreign_key => "battle_id",     :inverse_of => :battle

  belongs_to :initiator,    :class_name => "Fundamental::Character",  :foreign_key => "initiator_id"
  belongs_to :opponent,     :class_name => "Fundamental::Character",  :foreign_key => "opponent_id"
  
  belongs_to :region,       :class_name => "Map::Region",             :foreign_key => "region_id",     :inverse_of => :battles
  belongs_to :location,     :class_name => "Map::Location",           :foreign_key => "location_id",   :inverse_of => :battles
  
  
  
  # starts a fight between two armies. if one of the armies is already 
  # involved in an ongoing battle, the other is added to the opposing
  # faction.
  def self.start_fight_between(attacker, defender)
    raise BadRequestError.new('both armies are already fighting') unless attacker.battle_id.nil? || defender.battle_id.nil?
    raise BadRequestError.new('armies NOT at same location') unless attacker.location_id == defender.location_id
    
    if (!attacker.battle_id.nil? && attacker.battle_id > 0)      # A) add defender to attacker's battle
      battle = attacker.battle
      battle.add_army(defender, battle.other_faction(attacker.faction.id))
    elsif (!defender.battle_id.nil? && defender.battle_id > 0)   # B) add attacker to defender's battle
      battle = defender.battle
      battle.add_army(attacker, battle.other_faction(defender.faction.id))
    elsif attacker.able_to_overrun?(defender)                     # C)
      self.overrun(attacker, defender)
    elsif defender.able_to_overrun?(attacker)                    # D)
      self.overrun(defender, attacker)
    else                                                         # E) create new battle (not involved, yet)
      Military::Battle.create_battle_between(attacker, defender)
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

    attacker.kills += killed_units               # add kills
    attacker.save
    # create message

    # defender:
    Military::Army.destroy(defender.id)
    # create message
  end
  
  def self.create_battle_between(attacker, defender)
      
  end

  def other_factions(id)
    self.factions.where("id != ?", id)
  end
  
  def other_faction(id)
    other_factions(id).first
  end
  
  def add_army(army, faction)
    
  end
  
  
end
