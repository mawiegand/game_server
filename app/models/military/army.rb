class Military::Army < ActiveRecord::Base
  
  belongs_to :location, :class_name => "Map::Location", :foreign_key => "location_id"
  belongs_to :region, :class_name => "Map::Region", :foreign_key => "region_id"
  
  belongs_to :target_location, :class_name => "Map::Location", :foreign_key => "target_location_id"
  belongs_to :target_region, :class_name => "Map::Region", :foreign_key => "target_region_id"
  
  belongs_to :alliance, :class_name => "Fundamental::Alliance", :foreign_key => "alliance_id"  
  belongs_to :owner, :class_name => "Fundamental::Character", :foreign_key => "owner_id"  
  
  has_one    :movement_command, :class_name => "Action::Military::MoveArmyAction", :foreign_key => "army_id"
  has_one    :details, :class_name => "Military::ArmyDetail", :foreign_key => "army_id"
  
  has_one    :battle_faction, :class_name => "Military::BattleFaction", :foreign_key => "army_id"
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
    self.mode === 2 # 2: fighting?
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

  
  private
  
    def set_parent_change_timestamps
      self.region.armies_changed_at = self.updated_at
      self.region.save
      
      self.location.armies_changed_at = self.updated_at
      self.location.save
      
      return true   # must return true as returning false breaks the callback chain
    end
  
end
