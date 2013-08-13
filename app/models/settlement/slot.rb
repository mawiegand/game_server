require 'util/formula'

class Settlement::Slot < ActiveRecord::Base
  
  belongs_to :settlement,  :class_name => "Settlement::Settlement",  :foreign_key => "settlement_id",  :inverse_of => :slots
  
  has_many   :jobs,        :class_name => "Construction::Job",       :foreign_key => "slot_id",        :inverse_of => :slot,   :order => 'position ASC'

  after_save   :propagate_level_changes
  after_commit :trigger_consistency_check

  scope :empty,    where(['(level IS NULL OR level = ?) AND building_id IS NULL', 0])
  scope :occupied, where(['(level IS NOT NULL AND level > ?) OR building_id IS NOT NULL', 0])

  def empty?
    self.level == 0 || self.level.nil?
  end

  # calculates the storage capacity provided by this slot for all
  # resource types. returns an array.
  def resource_capacity(result=nil)
    result ||= Array.new(GameRules::Rules.the_rules().resource_types.count, 0)
    return    if building_id.nil?
    
    building_type = GameRules::Rules.the_rules().building_types[self.building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?
    
    eval_resource_dependent_formulas(building_type[:capacity], self.level, result)
  end
  
  # calculates the base production produced by this slot for all
  # resource types. returns an array.
  def resource_production(result=nil)
    result ||= Array.new(GameRules::Rules.the_rules().resource_types.count, 0)
    return    if building_id.nil?
    
    building_type = GameRules::Rules.the_rules().building_types[self.building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?
    
    eval_resource_dependent_formulas(building_type[:production], self.level, result)
  end

  # calculates and returns an array of the production boni granted
  # by this slot
  def production_bonus(result=nil)
    result ||= Array.new(GameRules::Rules.the_rules().resource_types.count, 0)
    return    if building_id.nil?
    
    building_type = GameRules::Rules.the_rules().building_types[self.building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?
    
    eval_resource_dependent_formulas(building_type[:production_bonus], self.level, result)
  end
  
  # calculates the base production produced by this slot for 
  # experience points. only return the exp value.
  def experience_production
    return 0 if building_id.nil?

    building_type = GameRules::Rules.the_rules().building_types[self.building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?
    return 0 if building_type[:experience_production].nil?

    formula = Util::Formula.parse_from_formula(building_type[:experience_production])
    formula.apply(self.level)
  end

  # returns the number of unlocks this slot provides for the different queue
  # types.
  def queue_unlocks(unlocks=nil)
    unlocks ||= Array.new(GameRules::Rules.the_rules().queue_types.count, 0)
    return    if building_id.nil?
    
    building_type = GameRules::Rules.the_rules().building_types[self.building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?
    
    return    if building_type[:abilities].nil? || building_type[:abilities][:unlock_queue].nil?
    
    building_type[:abilities][:unlock_queue].each do |queue|
      unlocks[queue[:queue_type_id]] += self.level >= queue[:level] ? 1 : 0
    end
    
    unlocks
  end  
  
  # adds the speed factors this slot provides for the different queue
  # types.
  def queue_speedups(speedups=nil)
    speedups ||= Array.new(GameRules::Rules.the_rules().queue_types.count, 0.0)
    return    if building_id.nil?
    
    building_type = GameRules::Rules.the_rules().building_types[self.building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?
    
    return    if building_type[:abilities].nil? || building_type[:abilities][:speedup_queue].nil?
    
    building_type[:abilities][:speedup_queue].each do |entry| # TODO: handle different domains!
      speedup = Util::Formula.parse_from_formula(entry[:speedup_formula]).apply(self.level)
      speedups[entry[:queue_type_id]] += speedup
    end
    
    speedups
  end  
  
  def trading_carts
    return 0   if building_id.nil?
    
    building_type = GameRules::Rules.the_rules().building_types[building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?

    return 0   if building_type[:abilities][:trading_carts].blank?

    Util::Formula.parse_from_formula(building_type[:abilities][:trading_carts]).apply(self.level)
  end
  
  def unlock_building_slots
    return 0   if building_id.nil?
    
    building_type = GameRules::Rules.the_rules().building_types[building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?

    return 0   if building_type[:abilities][:unlock_building_slots].blank?

    Util::Formula.parse_from_formula(building_type[:abilities][:unlock_building_slots]).apply(self.level)
  end  
  
  def artifact_initiation_level
    return 0   if building_id.nil?
    
    building_type = GameRules::Rules.the_rules().building_types[building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?

    return 0   if building_type[:abilities][:unlock_artifact_initiation].blank?

    Util::Formula.parse_from_formula(building_type[:abilities][:unlock_artifact_initiation]).apply(self.level)
  end    

  def unlock_prevent_takeover
    return 0   if building_id.nil?

    building_type = GameRules::Rules.the_rules().building_types[building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?

    building_type[:abilities][:unlock_prevent_takeover].blank? || building_type[:abilities][:unlock_prevent_takeover] > self.level ? 0 : 1
  end

  # returns the number of command points the building on this slot provides
  def command_points
    return 0   if building_id.nil?
    
    building_type = GameRules::Rules.the_rules().building_types[building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?

    return 0   if building_type[:abilities][:command_points].blank?

    Util::Formula.parse_from_formula(building_type[:abilities][:command_points]).apply(self.level)
  end
  
  def assignment_level
    return 0   if building_id.nil?
    
    building_type = GameRules::Rules.the_rules().building_types[building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?

    return 0   if building_type[:abilities][:assignment_level].blank?

    Util::Formula.parse_from_formula(building_type[:abilities][:assignment_level]).apply(self.level)
  end
    
  
  # returns the number of command points the building on this slot provides
  def defense_bonus
    return 0   if building_id.nil?
    
    building_type = GameRules::Rules.the_rules().building_types[building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?

    return 0   if building_type[:abilities][:defense_bonus].blank?

    Util::Formula.parse_from_formula(building_type[:abilities][:defense_bonus]).apply(self.level)
  end  
  
  # returns the population at the building
  def population
    return 0   if building_id.nil?
    
    building_type = GameRules::Rules.the_rules().building_types[building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?

    return 0   if building_type[:population].blank?

    Util::Formula.parse_from_formula(building_type[:population]).apply(self.level)
  end

  # returns the army size bonus the building on this slot provides
  def army_size_bonus
    return 0   if building_id.nil?
    
    building_type = GameRules::Rules.the_rules().building_types[building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?

    return 0   if building_type[:abilities][:army_size_bonus].blank?

    Util::Formula.parse_from_formula(building_type[:abilities][:army_size_bonus]).apply(self.level)
  end

  # returns the garrison size bonus the building on this slot provides
  def garrison_size_bonus
    return 0   if building_id.nil?
    
    building_type = GameRules::Rules.the_rules().building_types[building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?

    return 0   if building_type[:abilities][:garrison_size_bonus].blank?

    Util::Formula.parse_from_formula(building_type[:abilities][:garrison_size_bonus]).apply(self.level)
  end
  
  # returns the garrison size bonus the building on this slot provides
  def alliance_size_bonus
    return 0   if building_id.nil?
    
    building_type = GameRules::Rules.the_rules().building_types[building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?

    return 0   if building_type[:abilities][:alliance_size_bonus].blank?

    Util::Formula.parse_from_formula(building_type[:abilities][:alliance_size_bonus]).apply(self.level)
  end

  def min_level
    return 0 if building_id.nil?
    settlement_type = GameRules::Rules.the_rules().settlement_types[self.settlement.type_id]
    settlement_type[:building_slots][self.slot_num][:level]
  end
  
  def max_level
    return 0 if building_id.nil?
    settlement_type = GameRules::Rules.the_rules().settlement_types[self.settlement.type_id]
    settlement_type[:building_slots][self.slot_num][:max_level]
  end
  
  def takeover_level_factor
    settlement_type = GameRules::Rules.the_rules.settlement_types[self.settlement.type_id]
    settlement_type[:building_slots][self.slot_num][:takeover_level_factor]
  end

  def takeover_destroy?
    return false if empty? || building_id.nil?
    building_type = GameRules::Rules.the_rules.building_types[building_id]
    building_type[:takeover_destroy]
  end

  def takeover_downgrade?
    return false if empty? || building_id.nil?
    building_type = GameRules::Rules.the_rules.building_types[building_id]
    building_type[:takeover_downgrade_by_levels] > 0
  end

  def takeover_downgrade_by_levels
    return 0 if empty? || building_id.nil?
    building_type = GameRules::Rules.the_rules.building_types[building_id]
    building_type[:takeover_downgrade_by_levels]
  end

  # creates a building of the given id in this slot. assumes, the
  # building can be build in this slot according to the rules 
  # (= does not check the rules). calls all necesary handlers to
  # add unlocks, speedups and effects associated with this building.
  #
  # This method does NOT handle resource-costs etc., it's just 
  # responsible for updating the slot and propagating all effects
  # that are related to this change.
  def create_building(building_id_to_build)
    raise BadRequestError.new('Tried to construct a building in a slot that is not empty.') unless self.empty?
    self.building_id = building_id_to_build
    self.level = 1
    propagate_change(building_id_to_build, 0, 1)
    propagate_experience(building_id_to_build, building_id_to_build, 0, 1)
    self.save    
  end

  
  # upgrades the building in this slot by one level. Also calls
  # all necessary handlers to update unlocks, speedups and effects
  # accordingly. Assumes, it's possible to do the building, does not
  # check the rules.
  #
  # This method does NOT handle resource-costs etc., it's just 
  # responsible for updating the slot and propagating all effects
  # that are related to this change.
  def upgrade_building
    raise BadRequestError.new('Tried to upgrade a non-existend building.') if self.building_id.nil?
    self.level = self.level + 1
    propagate_change(self.building_id, self.level - 1, self.level)
    propagate_experience(self.building_id, self.building_id, self.level - 1, self.level)
    self.save
    # TODO: propagation of other depending values needs to be implemented
  end
  
  
  
  # downgrades the building in this slot by one level. If the level
  # would reach zero, calls the destroy-building method instead.
  # Also calls all necessary handlers to update unlocks, speedups 
  # and effects accordingly. Assumes, it's possible to downgrade
  # the building, it does not check the rules.
  #  
  # This method does NOT handle resource-costs etc., it's just 
  # responsible for updating the slot and propagating all effects
  # that are related to this change.
  def donwgrade_building
    if level == 0 && building_id.nil?
      return false
    elsif level == 1
      return destroy_building
    else
      self.level -= 1
      propagate_change(self.building_id, self.level+1, self.level)
      self.save
    end
  end
  
  # downgrade building slots by more than one level
  def downgrade_building_by_levels(levels)
    if levels == 0 || (level == 0 && building_id.nil?)
      return false
    elsif level - levels <= min_level
      if min_level > 0
        self.level = min_level
        propagate_change(self.building_id, min_level, self.level)
        self.save
      else
        return destroy_building
      end
    else
      self.level -= levels
      propagate_change(self.building_id, self.level + levels, self.level)
      self.save
    end
  end
  
  # completely destroys the building in this slot, thus setting
  # the building id to null and the level to zero. Calls all
  # necessary handlers to remove effects, unlocks and speedups
  # connected with this building.
  #
  # This method does NOT handle resource-costs etc., it's just 
  # responsible for updating the slot and propagating all effects
  # that are related to this change.
  def destroy_building
    if self.level == 0 && self.building_id.nil?
      return false
    else
      old_building_id = self.building_id
      old_level = self.level
      self.level = 0
      self.building_id = nil
      propagate_change(old_building_id, old_level, 0)
      self.save
    end
  end
  
  # completely destroys the building in this slot, thus setting
  # the building id to null and the level to zero. Calls all
  # necessary handlers to remove effects, unlocks and speedups
  # connected with this building.
  #
  # This method does NOT handle resource-costs etc., it's just 
  # responsible for updating the slot and propagating all effects
  # that are related to this change.
  def convert_building
    if self.level == 0 && self.building_id.nil?
      return false
    else
      # old building sichern
      old_building_id = self.building_id
      old_level = self.level
      
      # new building id heraussuchen
      old_building_type = GameRules::Rules.the_rules.building_types[old_building_id]
      raise InternalServerError.new("Could not find building id #{old_building_id} in rules") if old_building_type.nil?
      
      conversion_option = old_building_type[:conversion_option]
      raise InternalServerError.new("Could not find conversion option for building id #{old_building_type[:id]} in rules") if conversion_option.nil?
      
      # new building id setzen
      new_building_type = nil
      GameRules::Rules.the_rules.building_types.each do |type|
        new_building_type = type if type[:symbolic_id].to_s == conversion_option[:building].to_s
      end

      new_building_id = new_building_type[:id]
      self.building_id = new_building_id
      
      # level berechnen
      level_formula = Util::Formula.parse_from_formula(conversion_option[:target_level_formula])
      new_level = level_formula.apply(old_level)
      
      # level setzen
      self.level = new_level
      
      # änderungen propagieren 
      propagate_change(old_building_id, old_level, 0)
      propagate_change(new_building_id, 0, new_level)
      propagate_experience(old_building_id, new_building_id, old_level, new_level)

      self.save
    end
  end
  
  def propagate_change(building_id, old_level, new_level)
    propagate_resource_production       building_id, old_level, new_level
    propagate_experience_production     building_id, old_level, new_level
    propagate_resource_production_bonus building_id, old_level, new_level
    propagate_resource_capacity         building_id, old_level, new_level
    propagate_abilities                 building_id, old_level, new_level
  end

  ############################################################################
  #
  #  SLOT BUBBLES
  #
  ############################################################################

  def has_bubble?
    !self.bubble_resource_id.nil?  # add xp
  end

  def redeem_bubble
    # redeem
    resources = []
    resources[self.bubble_resource_id] = self.bubble_amount
    self.settlement.owner.resource_pool.add_resources_transaction(resources)

    # generate_new_bubble
    self.generate_new_bubble(self.bubble_next_test_at)
  end

  def update_bubble_if_needed
    while (self.bubble_next_test_at.nil? || self.bubble_next_test_at < Time.now) && !self.has_bubble?
      self.generate_new_bubble(self.bubble_next_test_at)
    end

    self.has_bubble?
  end

  def advance_test_date(base_date)
    slot_bubble_config = GameRules::Rules.the_rules.slot_bubbles
    random = Random.rand(slot_bubble_config[:test_max_duration] - slot_bubble_config[:test_min_duration])
    self.bubble_next_test_at = base_date + slot_bubble_config[:test_max_duration] + random
  end

  def generate_new_bubble(base_date)

    base_date = Time.now if base_date.nil?

    # werte aus regeln holen
    slot_bubble_config = GameRules::Rules.the_rules.slot_bubbles
    random = Random.rand(1.0)

    idle_probability_formula = Util::Formula.parse_from_formula(slot_bubble_config[:idle_probability])
    idle_probability = idle_probability_formula.apply(self.level)

    puts "ip #{slot_bubble_config[:idle_probability]} #{self.level} #{idle_probability} #{random}"

    if random > idle_probability
      res_production = self.resource_production
      puts "rs #{res_production}"

      if res_production.nil?
        self.advance_test_date(base_date)
        self.save
        return false
      end

      # get tradable resources with real production
      selectable_resources = GameRules::Rules.the_rules.resource_types.select { |type| type[:tradable] && res_production[type[:id]] > 0 }

      if !selectable_resources.empty?
        selected_resource_id = selectable_resources.sample[:id]

        resource_percentage_formula = Util::Formula.parse_from_formula(slot_bubble_config[:resource_percentage])
        resource_percentage = resource_percentage_formula.apply(self.level)

        self.bubble_resource_id = selected_resource_id                                   # zufallswert aus recourceproduction des slots
        puts "amount #{res_production[selected_resource_id]} * #{resource_percentage}"
        self.bubble_amount = (res_production[selected_resource_id] * resource_percentage / 100.0).ceil  # prozentualer wert der slotproduction (siehe regeln)
        self.bubble_xp = (random * 100).floor % 2                                        # erstmal fix
      end
      self.advance_test_date(base_date)
      self.save
      true
    else
      self.bubble_resource_id = nil
      self.advance_test_date(base_date)
      self.save
      false
    end
  end

  ############################################################################
  #
  #  RESOURCE PRODUCTION CHANGES
  #
  ############################################################################

  def propagate_resource_production(building_id, old_level, new_level)
    building_type = GameRules::Rules.the_rules().building_types[building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?
    if building_type[:production]
      building_type[:production].each do |product|
        update_resource_production_for(product, old_level, new_level)
      end
      self.settlement.save               # if something has changed on settlement, save it  
    end
  end
  
  def update_resource_production_for(product, old_level, new_level)
    resource_type = GameRules::Rules.the_rules().resource_types[product[:id]]
    attribute = resource_type[:symbolic_id].to_s()+'_base_production'
    
    formula = Util::Formula.parse_from_formula(product[:formula])
    delta = formula.difference(old_level, new_level)        # delta will be added, might be negative (that's abolutely ok)

    self.settlement[attribute] = (self.settlement[attribute] || 0.0) + delta
  end
  
  
  ############################################################################
  #
  #  EXPERIENCE CHANGES
  #
  ############################################################################

  def propagate_experience(building_id_old, building_id_new, old_level, new_level)
    formula = Util::Formula.parse_from_formula(GameRules::Rules.the_rules.building_experience_formula)
    experience = 0

    if building_id_old == building_id_new && new_level > old_level
      building_type = GameRules::Rules.the_rules.building_types[building_id_new]
      sum = 0
      (old_level + 1 .. new_level).each do |level|
        sum += formula.apply(level)
      end

      experience = (sum.to_f * (building_type[:experience_factor] || 1)).floor
    elsif building_id_old != building_id_new
      building_type_old = GameRules::Rules.the_rules.building_types[building_id_old]
      sum_old = 0
      (1 .. old_level).each do |level|
        sum_old += formula.apply(level)
      end
      exp_old = (sum_old.to_f * (building_type_old[:experience_factor] || 1)).floor

      building_type_new = GameRules::Rules.the_rules.building_types[building_id_new]
      sum_new = 0
      (1 .. new_level).each do |level|
        sum_new += formula.apply(level)
      end
      exp_new = (sum_new.to_f * (building_type_new[:experience_factor] || 1)).floor

      experience = exp_new - exp_old if exp_new > exp_old
    end

    if experience > 0
      self.settlement.owner.exp = (self.settlement.owner.exp || 0) + experience
      self.settlement.owner.save
    end
  end


  ############################################################################
  #
  #  EXPERIENCE PRODUCTION CHANGES
  #
  ############################################################################

  def propagate_experience_production(building_id, old_level, new_level)
    building_type = GameRules::Rules.the_rules().building_types[building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?
    if building_type[:experience_production]
      attribute = 'exp_production_rate_buildings'
      
      formula = Util::Formula.parse_from_formula(building_type[:experience_production])
      delta = formula.difference(old_level, new_level)        # delta will be added, might be negative (that's abolutely ok)
      
      self.settlement[attribute] = (self.settlement[attribute] || 0.0) + delta
      self.settlement.save               # if something has changed on settlement, save it  
    end
  end
  
  
  ############################################################################
  #
  #  RESOURCE PRODUCTION BONUS CHANGES
  #
  ############################################################################

  def propagate_resource_production_bonus(building_id, old_level, new_level)
    building_type = GameRules::Rules.the_rules().building_types[building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?
    if building_type[:production_bonus]
      building_type[:production_bonus].each do |bonus|
        update_resource_production_bonus_for(bonus, old_level, new_level)
      end
      self.settlement.save               # if something has changed on settlement, save it  
    end
  end
  
  def update_resource_production_bonus_for(bonus, old_level, new_level)
    resource_type = GameRules::Rules.the_rules().resource_types[bonus[:id]]
    attribute = resource_type[:symbolic_id].to_s()+'_production_bonus_buildings'
    
    formula = Util::Formula.parse_from_formula(bonus[:formula])
    delta = formula.difference(old_level, new_level)        # delta will be added, might be negative (that's abolutely ok)

    self.settlement[attribute] = (self.settlement[attribute] || 0.0) + delta
  end
  
  ############################################################################
  #
  #  RESOURCE CAPACITY CHANGES
  #
  ############################################################################

  def propagate_resource_capacity(building_id, old_level, new_level)
    building_type = GameRules::Rules.the_rules().building_types[building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?
    if building_type[:capacity]
      building_type[:capacity].each do |capacity|
        update_resource_capacity_for(capacity, old_level, new_level)
      end
      self.settlement.save               # if something has changed on settlement, save it  
    end
  end
  
  def update_resource_capacity_for(capacity, old_level, new_level)
    resource_type = GameRules::Rules.the_rules().resource_types[capacity[:id]]
    attribute = resource_type[:symbolic_id].to_s()+'_capacity'
    
    formula = Util::Formula.parse_from_formula(capacity[:formula])
    delta = formula.difference(old_level, new_level)        # delta will be added, might be negative (that's abolutely ok)

    self.settlement[attribute] = (self.settlement[attribute] || 0.0) + delta
  end
  
    
  ############################################################################
  #
  #  APPLY SPECIAL ABILITIES
  #
  ############################################################################

  # possible improvement: save domain once, after applying all changes.  
  def propagate_abilities(building_id, old_level, new_level)
    building_type = GameRules::Rules.the_rules().building_types[building_id]
    raise InternalServerError.new("did not find building id #{building_id} in rules.") if building_type.nil?
    if building_type[:abilities]
      if building_type[:abilities][:unlock_queue]
        building_type[:abilities][:unlock_queue].each do |rule| 
          propagate_unlock_queue(rule, old_level, new_level)
        end
      end
      if building_type[:abilities][:speedup_queue]
        building_type[:abilities][:speedup_queue].each do |rule| 
          propagate_speedup_queue(rule, old_level, new_level)
        end
      end
      if !building_type[:abilities][:defense_bonus].blank?
        propagate_evaluatable_settlement_ability(:defense_bonus, building_type[:abilities][:defense_bonus], old_level, new_level)
      end
      if !building_type[:abilities][:command_points].blank?
        propagate_evaluatable_settlement_ability(:command_points, building_type[:abilities][:command_points], old_level, new_level)
      end
      if !building_type[:abilities][:assignment_level].blank?
        propagate_evaluatable_settlement_ability(:assignment_level, building_type[:abilities][:assignment_level], old_level, new_level)
      end
      if !building_type[:abilities][:trading_carts].blank?
        propagate_evaluatable_settlement_ability(:trading_carts, building_type[:abilities][:trading_carts], old_level, new_level)
      end
      if !building_type[:abilities][:unlock_building_slots].blank?
        propagate_evaluatable_settlement_ability(:building_slots_total, building_type[:abilities][:unlock_building_slots], old_level, new_level)
      end
      if !building_type[:abilities][:army_size_bonus].blank?
        propagate_evaluatable_settlement_ability(:army_size_max, building_type[:abilities][:army_size_bonus], old_level, new_level)
      end
      if !building_type[:abilities][:garrison_size_bonus].blank?
        propagate_evaluatable_settlement_ability(:garrison_size_max, building_type[:abilities][:garrison_size_bonus], old_level, new_level)
      end
      if !building_type[:abilities][:unlock_p2p_trade].blank?
        propagate_unlock(:settlement_unlock_p2p_trade_count, building_type[:abilities][:unlock_p2p_trade], old_level, new_level)
      end
      if !building_type[:abilities][:unlock_prevent_takeover].blank?
        propagate_unlock(:settlement_unlock_prevent_takeover_count, building_type[:abilities][:unlock_prevent_takeover], old_level, new_level)
      end
      if !building_type[:abilities][:unlock_garrison].blank?
        propagate_unlock(:settlement_unlock_garrison_count, building_type[:abilities][:unlock_garrison], old_level, new_level)
      end
      if !building_type[:abilities][:unlock_diplomacy].blank?
        propagate_unlock(:settlement_unlock_diplomacy_count, building_type[:abilities][:unlock_diplomacy], old_level, new_level)
      end
      if !building_type[:abilities][:unlock_alliance_creation].blank?
        propagate_unlock(:settlement_unlock_alliance_creation_count, building_type[:abilities][:unlock_alliance_creation], old_level, new_level)
      end
      if !building_type[:abilities][:unlock_artifact_initiation].blank?
        propagate_evaluatable_settlement_ability(:artifact_initiation_level, building_type[:abilities][:unlock_artifact_initiation], old_level, new_level)
      end
      if !building_type[:abilities][:alliance_size_bonus].blank?
        propagate_evaluatable_settlement_ability(:alliance_size_bonus, building_type[:abilities][:alliance_size_bonus], old_level, new_level)
      end
    end
  end
  
  def propagate_evaluatable_settlement_ability(field, formula_string, old_level, new_level)
    formula = Util::Formula.parse_from_formula(formula_string)
    delta = formula.difference(old_level, new_level)        # delta will be added, might be negative (that's abolutely ok)
    
    if delta > 0.0 || delta < 0.0
      self.settlement[field] = (self.settlement[field] || 0) + delta
      self.settlement.save
    end
  end

  def propagate_unlock(field, at_level, old_level, new_level)
    if old_level < new_level && new_level == at_level
      self.settlement[field] = self.settlement[field] + 1
      self.settlement.save # save immediately, will destroy queue as a side effect
    elsif old_level > new_level && old_level == at_level
      self.settlement[field] = self.settlement[field] - 1
      self.settlement.save # save immediately, will destroy queue as a side effect
    end
  end

  
  # propagates unlock to the correct domain increasing or decreasing the
  # unlock counter as necessary
  def propagate_unlock_queue(rule, old_level, new_level)
    unlock_field = GameRules::Rules.the_rules().queue_types[rule[:queue_type_id]][:unlock_field]
    if old_level < new_level && new_level == rule[:level]
      self.settlement[unlock_field] = self.settlement[unlock_field] + 1
      self.settlement.save # save immediately, will create queue as a side effect
    elsif old_level > new_level && old_level == rule[:level]
      self.settlement[unlock_field] = self.settlement[unlock_field] - 1
      self.settlement.save # save immediately, will destroy queue as a side effect
    end
  end
  
  # propagates speedup to the correct domain increasing or decreasing the
  # speedup on that queue
  def propagate_speedup_queue(rule, old_level, new_level)
    formula = Util::Formula.parse_from_formula(rule[:speedup_formula])
    delta = formula.difference(old_level, new_level)        # delta will be added, might be negative (that's abolutely ok)
    queue_type = GameRules::Rules.the_rules().queue_types[rule[:queue_type_id]]
    
    if rule[:domain]    == :settlement
      self.settlement.propagate_speedup_to_queue(:building, queue_type, delta)
    elsif rule[:domain] == :character
      logger.error "Propagation of queue speedup for domain #{ rule[:domain] } not yet implemented."
    elsif rule[:domain] == :alliance
      logger.error "Propagation of queue speedup for domain #{ rule[:domain] } not yet implemented."
    else
      logger.error "Tried to propagate queue speedup to unkonwn domain #{ rule[:domain] }."      
    end
  end
  
  # method is called whenever a user creates a job for this slot
  def job_created(job)
    if job.job_type == Construction::Job::TYPE_CREATE && self.empty?
      self.building_id = job.building_id
      self.level = 0
      self.save
    end
  end
  
  # method is called whenever a user cancels a planned job for this slot
  def job_cancelled(job)
    if job.job_type == Construction::Job::TYPE_CREATE && self.empty?
      self.building_id = nil
      self.level = nil
      self.save
    end
  end
  
  # returns the level of the latest queued jobs, if there are any or
  # it returns the level of the slot itself
  # works for upgrades as well as downgrades
  def last_level
    if self.jobs.empty?
      self.level.nil? ? 0 : self.level
    else
      self.jobs.last.level_after
    end
  end
  
  protected
  
    def population_change(old_level, new_level)
      building_id = self.building_id
      if building_id.nil? && self.building_id_changed?
        building_id = building_id_change[0]   # old value
      end
      if building_id.nil?   # best, we can do!
        logger.error "Could not determine population change on slot #{ self.id}. Level changed from #{old_level} to #{new_level}."
        return (new_level || 0) - (old_level || 0)
      else  
        building_type = GameRules::Rules.the_rules().building_types[building_id]
        return (new_level || 0) - (old_level || 0)       if building_type.nil?

        formula = Util::Formula.parse_from_formula(building_type[:population])
        return formula.difference(old_level, new_level)    || 0    # delta will be added, might be negative (that's abolutely ok)
      end
    end
  
    def propagate_level_changes
      level_change = self.changes[:level] 
      if !level_change.nil? 
        population_change     = population_change(level_change[0] || 0,  level_change[1] || 0)
        self.settlement.score = (self.settlement.score || 0) + population_change                                 # this will be replaced with a scoring-function
        self.settlement.level = (self.settlement.level || 0) + (level_change[1] || 0) - (level_change[0] || 0)   # counts level
        self.settlement.save
      end
      true 
    end
    
    def trigger_consistency_check
      self.settlement.check_consistency_sometimes    unless self.settlement.nil?
      true
    end
    
    def eval_resource_dependent_formulas(formulas, level=nil, result=nil)
      result ||= Array.new(GameRules::Rules.the_rules().resource_types.count, 0)
      level  ||= self.level
      
      return     if formulas.nil?
        
      formulas.each do |entry|
        resource_type = GameRules::Rules.the_rules().resource_types[entry[:id]]
    
        formula = Util::Formula.parse_from_formula(entry[:formula])
        amount  = formula.apply(level)   

        result[entry[:id]] += amount
      end
      result
    end
  
end
