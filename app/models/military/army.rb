class Military::Army < ActiveRecord::Base
  
  belongs_to :location,           :class_name => "Map::Location",                    :foreign_key => "location_id",            :inverse_of => :armies
  belongs_to :region,             :class_name => "Map::Region",                      :foreign_key => "region_id",              :inverse_of => :armies

  belongs_to :home,               :class_name => "Settlement::Settlement",           :foreign_key => "home_settlement_id",     :inverse_of => :armies, :counter_cache => :armies_count
  
  belongs_to :target_location,    :class_name => "Map::Location",                    :foreign_key => "target_location_id"
  belongs_to :target_region,      :class_name => "Map::Region",                      :foreign_key => "target_region_id"
  
  belongs_to :alliance,           :class_name => "Fundamental::Alliance",            :foreign_key => "alliance_id",            :inverse_of => :armies
  belongs_to :owner,              :class_name => "Fundamental::Character",           :foreign_key => "owner_id",               :inverse_of => :armies
  
  has_one    :movement_command,   :class_name => "Action::Military::MoveArmyAction", :foreign_key => "army_id",                :dependent => :destroy
  has_one    :details,            :class_name => "Military::ArmyDetail",             :foreign_key => "army_id",                :dependent => :destroy, :inverse_of => :army
  
  belongs_to :battle,             :class_name => "Military::Battle",                 :foreign_key => "battle_id",              :inverse_of => :armies
  
  has_one    :battle_participant, :class_name => "Military::BattleParticipant",      :foreign_key => "army_id",                :inverse_of => :army
  has_one    :ranking,            :class_name => "Ranking::CharacterRanking",        :foreign_key => "max_experience_army_id", :inverse_of => :most_experienced_army
  has_one    :artifact,           :class_name => "Fundamental::Artifact",            :foreign_key => "army_id",                :inverse_of => :army

  validates  :ap_present, :numericality => { :greater_than_or_equal_to => 0 }
    
  before_save    :update_mode  
  before_save    :update_rank
  before_save    :update_units

  after_save     :update_experience_ranking
  after_save     :update_experience_and_kills_character
  after_save     :propagate_change_to_map
  after_save     :propagate_battle_to_settlement
  before_destroy :remove_from_experience_ranking 
  before_destroy :disband_from_battle

  after_create   :touch_map  
  after_create   :touch_home_settlement
  after_destroy  :remove_battle_from_settlement
  after_destroy  :touch_home_settlement

    
  after_find :update_ap_if_necessary
  
  MODE_IDLE = 0
  MODE_MOVING = 1
  MODE_FIGHTING = 2
  
  STANCE_DEFENDING_NONE = 0
  STANCE_DEFENDING_FORTRESS = 1

  scope :npc,           where('(npc = ?)', true)
  scope :non_npc,       where('(npc is null OR npc = ?)', false)
  scope :garrison,      where('(garrison = ?)', true)
  scope :non_garrison,  where('(garrison is null OR garrison = ?)', false)

  def self.create_garrison_at(settlement)
    logger.debug "Creating a second garrison army for settlement ID#{settlement.id}." unless settlement.garrison_army.nil? || settlement.garrison_army.frozen?
    
    army = settlement.build_garrison_army({
      location_id:  settlement.location_id,
      region_id:    settlement.region_id,  
      name:         'Garrison',
      owner_id:     settlement.owner_id,
      owner_name:   settlement.owner.name,
      npc:          settlement.owner.npc,
      alliance_id:  settlement.alliance_id,
      alliance_tag: settlement.alliance_tag,
      alliance_color: settlement.alliance_color,
      home_settlement_name: settlement.name,
      home_settlement_id:   settlement.id,
      ap_max:       4,
      ap_present:   0,
      ap_seconds_per_point: Military::Army.regeneration_duration,
      mode:         MODE_IDLE,
      kills:        0,
      victories:    0,
      size_max:     settlement.garrison_size_max || 1000,   # 1000 is default size
      exp:          0,
      rank:         0,
      garrison:     true,
      stance:       0,
    })
    
    if army.save 
      details = army.create_details
      return true 
    else
      return false
    end 
  end
  
  def self.create_settler_at_location(location, character)
    logger.debug "Creating a Settler-Army for character #{character.name}."
    
    settler_unit_type = Military::Army.default_settler_unit_type
    return false     if settler_unit_type.nil?
    
    army = location.armies.build({
      region_id:      location.region_id,  
      name:           settler_unit_type.name[character.locale],
      owner_id:       character.id,
      owner_name:     character.name,
      npc:            character.npc,
      alliance_id:    character.alliance_id,
      alliance_tag:   character.alliance_tag,
      alliance_color: character.alliance_color,
      home_settlement_name: "-",
      home_settlement_id:   nil,
      ap_max:       4,
      ap_present:   4,
      ap_seconds_per_point: Military::Army.regeneration_duration,
      mode:         MODE_IDLE,
      kills:        0,
      victories:    0,
      size_max:     1000,   # 1000 is default size
      exp:          0,
      rank:         0,
      garrison:     false,
      invisible:    true,
      stance:       0,
    })
    
    if army.save 
      details = army.create_details({
        settler_unit_type[:db_field] => 1
      })
      return true 
    else
      return false
    end
  end
  
  def self.default_settler_unit_type
    GameRules::Rules.the_rules.unit_types.each do |t|
      if !t[:can_create].nil? && t[:can_create] == 2
        return t
      end
    end
    nil
  end

  
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

  def number_of_units_of_type(unit_type)
    value = self.details[unit_type[:db_field]]
    return value if ((!value.nil?) && (value > 0))
    0
  end

  def number_of_units
    units = 0
    rules.unit_types.each do |unit_type|
      units = self.details[unit_type[:db_field]]
    end
    units
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
  
  def owned_by_npc?
    return self.owner.nil? || self.owner.npc?
  end
    
  def moving?
    self.mode === MODE_MOVING # 1 : moving?!
  end
  
  def fighting?
    !self.battle_id.nil? && self.battle_id > 0
  end
  
  def suspended?
    !self.suspension_ends_at.nil? && self.suspension_ends_at > Time.now
  end

  def protected?
    !self.attack_protection_ends_at.nil? && self.attack_protection_ends_at > Time.now
  end

  def defending?
    self.stance == Military::Army::STANCE_DEFENDING_FORTRESS
  end
    
  def can_found_outpost?
    return false    if self.details.nil?
    
    return false    if self.ap_present < 1
    
    founder = nil
    GameRules::Rules.the_rules.unit_types.each do |unit_type|
      founder = unit_type   if !unit_type[:can_create].nil? && !self.details[unit_type[:db_field]].nil? && self.details[unit_type[:db_field]] > 0
    end
    
    !founder.nil?
  end

  def move_to_location(target_location)
    self.location = target_location
    self.region = target_location.region
    self.save
  end
  
  def found_outpost!
    return   if owner.nil? || location.nil?    
    owner.update_settlement_points_used
    return   unless owner.can_found_outpost?
    return   unless location.can_found_outpost_here?
    return   unless can_found_outpost?
    
    settlement = Settlement::Settlement.create_settlement_at_location(location, 3, owner)    
    raise InternalServerError.new('Could not found outpost.') if settlement.nil?

    consume_ap
    consume_one_settlement_founder!
    
    settlement
  end
  
  def consume_one_settlement_founder!
    raise InternalServerError.new("no army details")   if self.details.nil?
      
    consume_type = nil
  
    GameRules::Rules.the_rules.unit_types.each do |unit_type|
      consume_type = unit_type   if !unit_type[:can_create].nil? && !self.details[unit_type[:db_field]].nil? && self.details[unit_type[:db_field]] > 0
    end
    
    raise InternalServerError.new("no settlement founder in army")   if consume_type.nil?
    
    self.details.decrement(consume_type[:db_field], 1)
    self.details.save!
    self.save!
    
    if self.empty?
      self.destroy
    end
  end
  
  def critical_damage_bonus
    logger.debug "ARMY RANK MODIFICATON: additional crit damage: #{ ((self.rank || 0) / 4).floor * 1 }."
    puts "ARMY RANK MODIFICATON: additional crit damage: #{ ((self.rank || 0) / 4).floor * 1 }."
    ((self.rank || 0) / 4).floor * 1   # 1 additonal crit damage per rank
  end

  def critical_hit_chance_modifier    
    logger.debug "ARMY RANK MODIFICATON: crit hit modifier: #{ (self.rank || 0) * 0.5 }."
    puts "ARMY RANK MODIFICATON: crit hit modifier: #{ (self.rank || 0) * 0.5 }."
    (self.rank || 0) * 0.5
  end
    
  def attack_modifier
    logger.debug "ARMY RANK MODIFICATON: att modifier: #{ (self.rank || 0) * 0.05 }."
    puts "ARMY RANK MODIFICATON: att modifier: #{ (self.rank || 0) * 0.05 }."
    (self.rank || 0) * 0.05     
  end     

  def hitpoints_modifier
    logger.debug "ARMY RANK MODIFICATON: hitpoints modifier: #{ (self.rank || 0) * 0.02 }."
    puts "ARMY RANK MODIFICATON: hitpoints modifier: #{ (self.rank || 0) * 0.02 }."
    (self.rank || 0) * 0.02     
  end 
  
  def self.base_move_duration
    (GAME_SERVER_CONFIG['movement_duration'] * GAME_SERVER_CONFIG['base_time_factor']).to_f
  end
  
  # returns the time needed for a move to the presently set target_region
  def move_duration_to_target
    relation = relation_to(self.target_region)
    
    relation_factor = if relation == Fundamental::Relation::RELATION_TYPE_SELF || relation == Fundamental::Relation::RELATION_TYPE_SAME_ALLIANCE
      0.15
    else 
      0.0
    end
    
    Military::Army.base_move_duration / ((self.velocity || 1.0) + relation_factor)
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
      if !unit_type[:overrunnable] && !defender.details[unit_type[:db_field]].nil? && defender.details[unit_type[:db_field]] > 0
        return false
      end
    end
    
    self.size_present > GAME_SERVER_CONFIG['overrunnable_threshold'] * defender.size_present
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
    
    started_battles
  end

  
  # checks if the current army is in the same existing alliance as other_army
  def same_alliance_as?(other_army)
    !self.alliance.nil? && !other_army.alliance.nil? && self.alliance == other_army.alliance
  end       
  
  # checks if the current army has the same owner as other_army
  def same_owner_as?(other_army)
    !self.owner.nil? && !other_army.owner.nil? && self.owner == other_army.owner
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
      if units[unit_type[:db_field]].to_i > (self.details[unit_type[:db_field]] || 0)
        return false
      end
    end
    true
  end
  
  # checks if the given army has the max size to receive the quantity of units stated in 'units_sum'. 
  def can_receive?(units_sum)
    self.size_max >= self.size_present + units_sum
  end
  
  def full?
    self.size_max <= self.size_present
  end
  

  # checks if the given army contains at least one unit.
  def empty?
    GameRules::Rules.the_rules.unit_types.each do | unit_type |
      if !self.details[unit_type[:db_field]].nil? && (self.details[unit_type[:db_field]] || 0) > 0
        return false
      end
    end
    true
  end

  # adds the units of given army by the units stated as key/value pairs in 'units' 
  def add_units(units)
    GameRules::Rules.the_rules.unit_types.each do | unit_type |
      self.details.increment(unit_type[:db_field], units[unit_type[:db_field]].to_i)
    end
    self.details.save
  end

  # by calling self.save the units are cut to fit into army.size_max to avoid throwing an exception
  def add_units_safely(units)
    GameRules::Rules.the_rules.unit_types.each do | unit_type |
      self.details.increment(unit_type[:db_field], units[unit_type[:db_field]].to_i)
    end

    self.details.reduce_units_to_size_max
    self.save
  end

  # reduces the units of given army by the units stated as key/value pairs in 'units'
  def reduce_units(units)
#   Military::ArmyDetails.transaction do
    GameRules::Rules.the_rules.unit_types.each do | unit_type |
      unless units[unit_type[:db_field]].nil?
        self.details.decrement(unit_type[:db_field], units[unit_type[:db_field]].to_i)
      end
    end
    self.details.save
#   end
  end
  
  def self.experience_value_of(units)
    sum = 0
    GameRules::Rules.the_rules.unit_types.each do | unit_type |
      unit = units[unit_type[:db_field]]
      if !unit_type[:costs].blank? && !unit.nil?
        costs = 0
        unit_type[:costs].each do |unit_type_id, cost|
          costs += cost.to_i
        end
        sum += (unit * (costs * 0.08).floor * unit_type[:experience_factor]).floor
      end
    end
    sum
  end

  def self.create_npc(location, size)
    raise BadRequestError.new('No location for army creation!') if location.nil?
    npc = Fundamental::Character.find_by_id(1)
    
    army = Military::Army.new({
      name: I18n.translate('application.military.neanderthal'),
      ap_max: 4,
      ap_present: 4,
      ap_seconds_per_point: Military::Army.regeneration_duration,
      mode: Military::Army::MODE_IDLE,
      stance: 0, 
      size_max: 2000,
      exp: 0,
      rank: 0,
      ap_next: DateTime.now.advance(:seconds => Military::Army.regeneration_duration),
      garrison: false,
      kills: 0,
      victories: 0,
      npc: true,
      home_settlement_name: I18n.translate('application.settlement.neanderthal')
    })
    
    army.location = location
    army.region = location.region
    army.owner = npc
    army.owner_name = npc.name
    army.alliance = npc.alliance
    army.alliance_tag = npc.alliance_tag
    
    details = army.build_details()
    
    GameRules::Rules.the_rules.unit_types.each do | unit_type |
      if unit_type[:symbolic_id] == :neanderthal
        details[unit_type[:db_field]] = [size.to_i, army.size_max].min
      else
        details[unit_type[:db_field]] = 0
      end
    end

    army.save
    army
  end
  
  # creates a new army. create_action must contain the home location id and the units of the new army.
  def self.create_with_action(create_action)
    
    location = Map::Location.find(create_action[:location_id])
    raise BadRequestError.new('No location for army creation!') if location.nil?
    
    army_name = create_action[:army_name]
    if army_name.nil? || army_name.empty? || army_name === '' || army_name === 'null'
      army_name = I18n.translate('application.military.new_army')
    end

    army = Military::Army.new({
      name: army_name[0..15],
      home_settlement_id: location.settlement.id,
      home_settlement_name: location.settlement.name,
      ap_max: 4,
      ap_present: 2,
      ap_seconds_per_point:  Military::Army.regeneration_duration,
      mode: Military::Army::MODE_IDLE,
      stance: 0, 
      size_max: location.settlement.army_size_max || 1000,  # 1000 is default size
      exp: 0,
      rank: 0,
      ap_next: DateTime.now.advance(:seconds =>  Military::Army.regeneration_duration),
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
    army.alliance_color = army.owner.alliance_color

    details = army.build_details()
    
    GameRules::Rules.the_rules.unit_types.each do | unit_type |
      if create_action[unit_type[:db_field]]
        details[unit_type[:db_field]] = create_action[unit_type[:db_field]].to_i
      else
        details[unit_type[:db_field]] = 0
      end
    end
    
    # update from details before save to be sure that size_present is set
    army.update_from_details
    
    army.save
  end
  
  def delete_movement
    self.movement_command.destroy
    self.target_location = nil
    self.target_region = nil
    self.target_reached_at = nil
    self.mode = MODE_IDLE
    self.save
  end
  
  def owner_name_and_ally_tag
    self.alliance_tag.nil? ? self.owner_name : self.owner_name + ' | ' + self.alliance_tag
  end
  
  def hidden_garrison_fields
    ApplicationController.expand_fields(self, [ 'unitcategory_', :size_present, :strength ] )
  end
  
  
  # Only serialize the visible fields according to the user's role, if specified as an option.
  # The rules are as follows:
  # If nothing is specified, the details are included. If only is specified, but does not include
  # the details, details are not included. If except is specified and details are included there,
  # details are not included.
  #
  # For garrisons, the hidden_garrison_fields are removed, if the present role is not at least :owner.
  def as_json(options={})
    if ((!options[:role].nil? && options[:role] == :owner) || !self.garrison?)
      if (options[:except].nil? || !options[:except].include?(:details)) && (options[:only].nil? || options[:only].include?(:details))
        options[:include] = { :details => {} }
      end
      super(options)      
    else
      if self.garrison? && self.battle_id.nil?
        if options[:only].nil?
          options[:except] = (options[:except] || []).concat hidden_garrison_fields
        else
          to_remove = hidden_garrison_fields
          options[:only] = options[:only].reject { |item| to_remove.include? item }   
        end   
      end
      super(options)
    end
  end

  def check_and_repair_name
    if self.home.name != self.home_settlement_name
      logger.warn(">>>ARMY NAME DIFFERS. Old: #{self.home_settlement_name} Corrected: #{self.home.name}.")
      self.home_settlement_name = self.home.name
    end
  end

  def check_consistency
    check_and_repair_name

    if self.changed?
      logger.info(">>> SAVING ARMY AFTER DETECTING ERRORS.")
      self.save
    else
      logger.info(">>> ARMY OK.")
    end

    true
  end

  private
  
    # before safe handler setting the correct mode in case the battle id has
    # changed.
    def update_mode
      battle_id_change = self.changes[:battle_id]
      unless battle_id_change.nil?
        self.mode = battle_id_change[1].nil? ? MODE_IDLE : MODE_FIGHTING
      end
      true
    end

    def self.rank_progression 
      return @rank_progression    if !@rank_progression.blank?
      @rank_progression = [ 0, 30, 60 ]   # thresholds for rank 0 1 2   
      (3..19).each { |rank| @rank_progression[rank] = @rank_progression[rank-1] + @rank_progression[rank-2] }
      logger.debug "Calculated rank progression: #{@rank_progression.inspect}."
      @rank_progression
    end
    
    # update the rank on changed experience. Dirty-handler makes sure
    # the rank attribute is only updated in the database in case
    # it actually changed.
    def update_rank
      return true      if self.exp.blank? 
      
      while  (self.rank || 0) +1 < 20 && Military::Army.rank_progression[(self.rank || 0) +1] < (self.exp || 0) do
        self.rank = (self.rank || 0) + 1
      end

      true
    end
    
    def update_experience_ranking
      return true    if self.npc?
      return true    if self.owner.blank?
      return true    if self.owner.ranking.blank?  # true e.g. for npc, or on a bug ;-)
    
      if !self.changes[:exp].blank? && self.owner.ranking.max_experience < (self.exp || 0)
        self.owner.ranking.update_max_experience_from_army(self)
        self.owner.ranking.save
      else     # in case this army is the best army, propagate changes to name and rank.
        name_change     = self.changes[:name]
        rank_change     = self.changes[:rank]
        if (!name_change.blank? || !rank_change.blank?) && self.ranking
          self.ranking.update_max_experience_from_army(self)
          self.ranking.save
        end
      end

      true
    end
    
    def update_experience_and_kills_character
      return true    if self.owner.blank?
    
      if !self.changes[:exp].blank?
        delta = (self.exp_change[1] || 0)-(self.exp_change[0] || 0)
        self.owner.increment(:exp, (delta * (1 + (self.owner.exp_bonus_total || 0))).floor)
      end

      if !self.changes[:kills].blank?
        delta = (self.kills_change[1] || 0)-(self.kills_change[0] || 0)
        self.owner.increment(:kills, delta)
      end
      
      self.owner.save # saves only in case something has actually changed.

      true
    end    
    
    # reduces units evenly when army_size_max is reduced
    def update_units
      if !self.size_present.blank? && !self.size_max.blank? && self.size_present > self.size_max
        self.details.reduce_units_to_size_max
      end
    end
    
    # before destroy handler that removes this army from the experience ranking
    # in case it was the best army the player had.
    def remove_from_experience_ranking
      if !self.npc? && self.ranking # best army?
        self.ranking.recalc_max_experience(self.id)  # recalc and ignore this army
        self.ranking.save
      end
      true
    end

    def remove_battle_from_settlement
      if self.garrison? && !self.home.nil?
        self.home.battle_id = nil 
        self.home.save
      end
      true
    end

    def touch_home_settlement
      if !self.home.nil?  
        self.home.touch
      end
      true
    end

    def touch_map
      if !self.region.nil?
        self.region.touch
      end
      if !self.location.nil?
        self.location.touch
      end
      true
    end    
    
    def disband_from_battle
      participant = self.battle_participant
      return if participant.nil?
      participant.disbanded = true
      participant.save
      true
    end
      
      
    def propagate_battle_to_settlement
      if self.battle_id_changed? && self.garrison? && !self.home.nil?
        self.home.battle_id = self.battle_id
        self.home.save
      end
      true
    end
    
    # updates the armies_changed_at  timestamp in regions and locations. That
    # timestamp is used in case the client fetches armies for a location and 
    # region in order to determine whether to send data or a not_modified reply.
    def propagate_change_to_map
      return true       if self.garrison?    # don't update change timestamp for armies inside settlements (would trigger to much client updates due to unit training.)
      
      change_timestamp = Time.now
      
      logger.debug "Set armies changed timestamp at present region and location."
      if !self.region.nil?
        self.region.armies_changed_at   = change_timestamp
        self.region.save
      end
      if !self.location.nil?
        self.location.armies_changed_at = change_timestamp
        self.location.save
      end
      if self.region_id_changed? && !self.region_id_change[0].blank?
        logger.debug "Set armies changed timestamp at old region."
        old_region = Map::Region.find_by_id(self.region_id_change[0])
        unless old_region.nil?
          old_region.armies_changed_at = change_timestamp    
          old_region.save
        end
      end      
      if self.location_id_changed? && !self.location_id_change[0].blank?
        logger.debug "Set armies changed timestamp at old location."
        old_location = Map::Location.find_by_id(self.location_id_change[0])
        unless old_location.nil?
          old_location.armies_changed_at = change_timestamp    
          old_location.save
        end
      end
      
      true
    end
end
