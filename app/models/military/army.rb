class Military::Army < ActiveRecord::Base
  
  belongs_to :location, :class_name => "Map::Location", :foreign_key => "location_id"
  belongs_to :region, :class_name => "Map::Region", :foreign_key => "region_id"

  belongs_to :home, :class_name => "Settlement::Settlement", :foreign_key => "home_settlement_id", :counter_cache => :armies_count, :inverse_of => :armies

  
  belongs_to :target_location, :class_name => "Map::Location", :foreign_key => "target_location_id"
  belongs_to :target_region, :class_name => "Map::Region", :foreign_key => "target_region_id"
  
  belongs_to :alliance, :class_name => "Fundamental::Alliance", :foreign_key => "alliance_id"  
  belongs_to :owner, :class_name => "Fundamental::Character", :foreign_key => "owner_id"  
  
  has_one    :movement_command, :class_name => "Action::Military::MoveArmyAction", :foreign_key => "army_id"
  has_one    :details, :class_name => "Military::ArmyDetail", :foreign_key => "army_id"
  
  belongs_to :battle, :class_name => "Military::Battle", :foreign_key => "battle_id", :inverse_of => :armies
  has_one    :battle_participant, :class_name => "Military::BattleParticipant", :foreign_key => "army_id"
  
  validates  :ap_present, :numericality => { :greater_than_or_equal_to => 0 }
    
  after_find :update_ap_if_necessary
  after_save :set_parent_change_timestamps
  
  def self.regeneration_duration
    GAME_SERVER_CONFIG['ap_regeneration_duration'] * GAME_SERVER_CONFIG['base_time_factor']
  end
  
  
  # returns whether an action point update is overdue
  def needs_ap_update?
    logger.debug("AP presently: #{ ap_present } / #{ ap_max } next regeneration at #{ ap_next }.")
    (ap_present < ap_max && (ap_next.nil? || ap_next > Time.now))  ||  (!ap_next.nil? && Time.now > ap_next)     #GAME_SERVER_CONFIG['ap_regeneration_time'])
  end  
  
  def update_ap
    # AP = MIN [ AP_MAX, (INTERVAL(now - ap_last) * REGENERATION_TIME) ]
    if ap_present >= ap_max && !ap_next.nil?
      logger.error("inconsistent state in database: #{ ap_present } of #{ ap_max } action points, but set ap_next to #{ ap_next }. FIXED THIS BY SETTING AP_NEXT TO: nil.")
      self.ap_next = nil
      self.save
    elsif ap_present < ap_max && ap_next.nil?
      self.ap_next = Time.now.advance(:seconds => Military::Army.regeneration_duration)     # regeneration time
      logger.error("inconsistent state in database: #{ ap_present } of #{ ap_max } action points, but not set ap_next. FIXED THIS BY SETTING AP_NEXT TO: #{ ap_next }.")
      self.save
    elsif ap_present < ap_max && !ap_next.nil?
      changed = false
      while (!self.ap_next.nil? && self.ap_next < Time.now)
        changed = true
        logger.error("Regenerate one AP: #{ ap_present }+1 of #{ ap_max } should have been regenerated at #{ ap_next }, was regenerated at #{ Time.now }.")        
        self.ap_present += 1
        self.ap_next = self.ap_present < self.ap_max ? self.ap_next.advance(:seconds => Military::Army.regeneration_duration) : nil    # add regeneration time or nil, in case it's fully regenerated
      end 
      self.save if changed
    end
  end

  def has_units?
    rules = rules = GameRules::Rules.the_rules
    rules.unit_types.each do |t|
      value = self.details[t[:db_field]]
      return true if ((!value.nil?) && (value > 0))
    end
    false
  end

  def update_ap_if_necessary
    update_ap if needs_ap_update?
  end
  
  def consume_ap(n=1)
    update_ap_if_necessary
    raise BadRequestError.new('Should consume more AP than available.') if n > self.ap_present   # NOT beautiful: USE A NOT-HTTP-RELATED EXCEPTION
    self.ap_present -= n
    if self.ap_next.blank?
      self.ap_next = Time.now.advance(:seconds => Military::Army.regeneration_duration)     # regeneration time
    end
  end
  
  def owned_by?(character_id)
    self.owner_id === character_id
  end
  
  def moving?
    !self.target_location_id.blank? || self.mode === 1 # 1 : moving?!
  end
  
  def fighting?
    # self.mode === 2 # 2: fighting?
    !self.battle_id.nil? && self.battle_id > 0
  end
  
  def relation_to(other_army)
    if other_army.nil?
      return Fundamental::Relation::RELATION_TYPE_UNKNOWN
    end

    if self.owner_id == other_army.owner_id
      return Fundamental::Relation::RELATION_TYPE_SELF
    elsif self.alliance_id.nil?
      return Fundamental::Relation::RELATION_TYPE_NEUTRAL
    elsif other_army.alliance_id.nil?
      return Fundamental::Relation::RELATION_TYPE_NEUTRAL
    elsif self.alliance_id == other_army.alliance_id
      return Fundamental::Relation::RELATION_TYPE_SAME_ALLIANCE
    elsif self.alliance_id != other_army.alliance_id
      return Fundamental::Relation::RELATION_TYPE_AT_WAR
    else
      return Fundamental::Relation::RELATION_TYPE_UNKNOWN
    end
  end
  
  # this methods tests if the army is able to overrun another army.
  # the defending army may not be a garrison army and may not
  # contain a unit, which is not overrunnable. the attacking army must
  # also exceed the defending army by factor 'overrunnable_threshold'
  def able_to_overrun?(defender)
    
    if defender.garrison
      return false
    end
    
    GameRules::Rules.the_rules.unit_types.each do |unit_type|
      if !unit_type[:overrunnable] && !self.details[unit_type[:db_field]].nil? && self.details[unit_type[:db_field]] > 0
        return false
      end
    end
    
    return self.size_present > GAME_SERVER_CONFIG['overrunnable_threshold'] * defender.size_present
  end  
  
  # checks if a change in the army causes a new battle with 
  # existing armies at current location
  def check_for_battle_at(location)
    garrison_army = location.garrison_army
    
    started_battles = 0
    unless garrison_army.nil?
      location.armies.each do |other_army|
        if (other_army != garrison_army &&
            other_army.owner_id != garrison_army.owner_id &&
            !other_army.fighting? &&
            !other_army.owner.right_of_way_at(location))
          puts "new battle"
          Military::Battle.start_fight_between(garrison_army, other_army)
          started_battles += 1
        end
      end
    end
    
    return started_battles
  end
  
  # implement an arbitrary formula calculating the unit's strength here. is
  # used to caclulate the army's strength and the strength of particular
  # troop categories (infantry, artillery, etc.)
  # Present implementation: attack value + critical damage * chance for 
  # critical hit. Will be the average inflicted damage ignoring the 
  # opponents armor and efficiencies.
  def self.calc_unit_strength(unit_type)
    (unit_type[:attack] + unit_type[:critical_hit_damage] * unit_type[:critical_hit_chance]) 
  end
  
  # this method updates the aggregated army information from the unit-details.
  # it updates 
  #  A) the velocity to be the MIN of all unit types in the army
  #  B) the size to be the sum of the individual units
  #  C) the strength (per category as well as the total) to the sum of the
  #     individual unit's strengths multiplied by their number.
  def update_from_details
    vel = 99999
    n = 0
    
    strength_per_cat = {};
    
    GameRules::Rules.the_rules.unit_types.each do | unit_type |
      if !self.details[unit_type[:db_field]].nil? && self.details[unit_type[:db_field]] > 0
        n += self.details[unit_type[:db_field]] 
        if unit_type[:velocity] < vel 
          vel = unit_type[:velocity]
        end
        cat = unit_type[:category]
        strength_per_cat[cat] ||= 0.0
        strength_per_cat[cat] += Military::Army.calc_unit_strength(unit_type) * self.details[unit_type[:db_field]]
      end
    end
    
    self.velocity = vel > 0 ? vel : 1.0   # velocity must always be larger than zero
    self.size_present = n
    
    logger.debug "Strengthes per category: #{strength_per_cat}."
        
    self.strength = 0.0
    
    GameRules::Rules.the_rules.unit_categories.each do | unit_category |
      value = strength_per_cat[unit_category[:id]] || 0
      self.send((unit_category[:db_field].to_s+'_strength=').to_sym, value)
      self.strength += value
    end
    
    self.save
  end

  # checks if the given army contains the quantity of units stated as key/value pairs in 'units'. 
  def contains?(units)
    GameRules::Rules.the_rules.unit_types.each do | unit_type |
      if units[unit_type[:db_field]].to_i > self.details[unit_type[:db_field]]
        return false
      end
    end
    true
  end

  # reduces the units of given army by the units stated as key/value pairs in 'units' 
  def reduce_units(units)
    GameRules::Rules.the_rules.unit_types.each do | unit_type |
      puts "reduce = "+units[unit_type[:db_field]].to_i.to_s
      self.details[unit_type[:db_field]] -= units[unit_type[:db_field]].to_i
    end
    self.details.save
  end
  
  # creates a new army. create_action must contain the home location id and the units of the new army.
  def self.create_with_action(create_action)
    
    location = Map::Location.find(create_action[:location_id])
    raise BadRequestError.new('No location for army creation!') if location.nil? 
    
    army = Military::Army.new({
      name: 'New Army',
      home_settlement_id: location.settlement.id,
      home_settlement_name: location.settlement.name,
      ap_max: 4,
      ap_present: 4,
      ap_seconds_per_point: 3600,
      mode: 0,
      stance: 0, 
      size_max: 100,
      exp: 0,
      rank: 0,
      ap_next: DateTime.now.advance(:minutes => 1),
      garrison: false,
      kills: 0,
      victories: 0,
    })
    
    army.location = location
    army.region = location.region
    army.home = location.settlement
    army.owner = location.owner
    army.owner_name = army.owner.name
    army.alliance = army.owner.alliance
    army.alliance_tag = army.owner.alliance_tag
    
    details = army.build_details()
    
    GameRules::Rules.the_rules.unit_types.each do | unit_type |
      if create_action[unit_type[:db_field]]
        details[unit_type[:db_field]] = create_action[unit_type[:db_field]].to_i
      else
        details[unit_type[:db_field]] = 0
      end
    end
    
    army.save
  end
  
  private
  
    def set_parent_change_timestamps
      self.region.armies_changed_at = self.updated_at
      self.region.save
      
      self.location.armies_changed_at = self.updated_at
      self.location.save
      
      return true   # must return true as returning false breaks the callback chain
    end
  
end
