require 'util/formula'

class Settlement::Slot < ActiveRecord::Base
  
  belongs_to :settlement,  :class_name => "Settlement::Settlement",  :foreign_key => "settlement_id",  :inverse_of => :slots
  
  has_many   :jobs,        :class_name => "Construction::Job",       :foreign_key => "slot_id",        :inverse_of => :slot,   :order => 'position ASC'

  after_save   :propagate_level_changes
  after_commit :trigger_consistency_check

  def empty?
    return self.level == 0 || self.level.nil?
  end
  
  # calculates the base production produced by this slot for all
  # resource types. returns an array.
  def resource_production(result=nil)
    result ||= Array.new(GameRules::Rules.the_rules().resource_types.count, 0)
    return    if building_id.nil?
    
    building_type = GameRules::Rules.the_rules().building_types[self.building_id]
    raise InternalServerError.new('did not find building id #{building_id} in rules.') if building_type.nil?
    
    eval_resource_dependent_formulas(building_type[:production], self.level, result)
  end

  # calculates and returns an array of the production boni granted
  # by this slot
  def production_bonus(result=nil)
    result ||= Array.new(GameRules::Rules.the_rules().resource_types.count, 0)
    return    if building_id.nil?
    
    building_type = GameRules::Rules.the_rules().building_types[self.building_id]
    raise InternalServerError.new('did not find building id #{building_id} in rules.') if building_type.nil?
    
    eval_resource_dependent_formulas(building_type[:production_bonus], self.level, result)
  end
  
  # returns the number of unlocks this slot provides for the different queue
  # types.
  def queue_unlocks(unlocks=nil)
    unlocks ||= Array.new(GameRules::Rules.the_rules().queue_types.count, 0)
    return    if building_id.nil?
    
    building_type = GameRules::Rules.the_rules().building_types[self.building_id]
    raise InternalServerError.new('did not find building id #{building_id} in rules.') if building_type.nil?
    
    return    if building_type[:abilities].nil? || building_type[:abilities][:unlock_queue].nil?
    
    building_type[:abilities][:unlock_queue].each do |queue|
      unlocks[queue[:queue_type_id]] += self.level >= queue[:level] ? 1 : 0
    end
    
    unlocks
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
    propagate_change(self.building_id, self.level-1, self.level)
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
  
  def propagate_change(building_id, old_level, new_level)
    propagate_resource_production       building_id, old_level, new_level
    propagate_resource_production_bonus building_id, old_level, new_level
    propagate_abilities                 building_id, old_level, new_level
  end
    
  ############################################################################
  #
  #  RESOURCE PRODUCTION CHANGES
  #
  ############################################################################

  def propagate_resource_production(building_id, old_level, new_level)
    building_type = GameRules::Rules.the_rules().building_types[building_id]
    raise InternalServerError.new('did not find building id #{building_id} in rules.') if building_type.nil?
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
  #  RESOURCE PRODUCTION BONUS CHANGES
  #
  ############################################################################

  def propagate_resource_production_bonus(building_id, old_level, new_level)
    building_type = GameRules::Rules.the_rules().building_types[building_id]
    raise InternalServerError.new('did not find building id #{building_id} in rules.') if building_type.nil?
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
  #  APPLY SPECIAL ABILITIES
  #
  ############################################################################

  # possible improvement: save domain once, after applying all changes.  
  def propagate_abilities(building_id, old_level, new_level)
    building_type = GameRules::Rules.the_rules().building_types[building_id]
    raise InternalServerError.new('did not find building id #{building_id} in rules.') if building_type.nil?
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
      if !building_type[:abilities][:unlock_garrison].blank?
        propagate_unlock(:settlement_unlock_garrison_count, building_type[:abilities][:unlock_garrison], old_level, new_level)
      end
      if !building_type[:abilities][:unlock_diplomacy].blank?
        propagate_unlock(:settlement_unlock_diplomacy_count, building_type[:abilities][:unlock_diplomacy], old_level, new_level)
      end
      if !building_type[:abilities][:unlock_alliance_creation].blank?
        propagate_unlock(:settlement_unlock_alliance_creation_count, building_type[:abilities][:unlock_alliance_creation], old_level, new_level)
      end      
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
    
    if rule[:domain] == :settlement
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
      return self.level.nil? ? 0 : self.level
    else
      return self.jobs.last.level_after
    end
  end
  
  protected
  
    def propagate_level_changes
      level_change = self.changes[:level] 
      if !level_change.nil? 
        self.settlement.score = (self.settlement.score || 0) + (level_change[1] || 0) - (level_change[0] || 0)   # this will be replaced with a scoring-function
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
