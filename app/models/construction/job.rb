require 'util/formula'
require 'game_state/requirements'

class Construction::Job < ActiveRecord::Base
  
  has_one    :active_job,  :class_name => "Construction::ActiveJob", :foreign_key => "job_id",    :inverse_of => :job, :dependent => :destroy
  
  belongs_to :queue,       :class_name => "Construction::Queue",     :foreign_key => "queue_id",  :inverse_of => :jobs,  :counter_cache => true, :touch => true
  belongs_to :slot,        :class_name => "Settlement::Slot",        :foreign_key => "slot_id",   :inverse_of => :jobs
  
  TYPE_CREATE = 'create'
  TYPE_UPGRADE = 'upgrade'
  TYPE_DOWNGRADE = 'downgrade'
  TYPE_DESTROY = 'destroy'
  
  def active?
    !self.active_job.nil?
  end
  
  def building_time
    rules = GameRules::Rules.the_rules
    formula = Util::Formula.parse_from_formula(rules.building_types[self.building_id][:production_time])
    if self.job_type == TYPE_CREATE || self.job_type == TYPE_UPGRADE
      return formula.apply(self.level_after)
    elsif self.job_type == TYPE_DESTROY
      time = 0
      1.upto(self.level_before) do |level|
        time += formula.apply(level)
      end
      return time
    end
  end
  
  def costs
    costs = {}
    unless self.job_type == TYPE_DESTROY
      buildingType = GameRules::Rules.the_rules.building_types[self.building_id]
      return {} if buildingType[:costs].nil?
      buildingType[:costs].each do |resource_id, formula|
        f = Util::Formula.parse_from_formula(formula)
        costs[resource_id] = f.apply(self.level_after)
      end
    end
    return costs
  end
  
  def last_in_slot
    self == self.queue.sorted_jobs_for_slot(self.slot).last
  end
  
  # checks if a job can be queueable due to requirements like e.g. building levels
  def queueable?
    slot = self.slot
    settlement = slot.settlement
    owner = settlement.owner
    
    # get requirements from rules
    building_type = GameRules::Rules.the_rules.building_types[self.building_id]
    requirementGroups = building_type[:requirementGroups]
    
    unless self.job_type == TYPE_DESTROY
      # test if requirements are met
      logger.debug requirementGroups.inspect
      raise ForbiddenError.new('Requirements not met.')  if !requirementGroups.nil? && !requirementGroups.empty? && !GameState::Requirements.meet_one_requirement_group?(requirementGroups, owner, settlement, slot)
    else
      # test if building types match
      raise ForbiddenError.new('Wrong building type.') unless slot.building_id == self.building_id
      raise ForbiddenError.new('Building type is not demolishable.') unless building_type[:demolishable] && building_type[:demolishable] == true
    end

    #TODO testen ob destroy job schon vorhanden ist

    # test if queue is already full   
    raise ForbiddenError.new('Queue is already full.') if self.queue && self.queue.max_length <= (self.queue.jobs_count || 0)
    
    # test same job type if queue has already jobs
    raise ForbiddenError.new('Not allowed to mix destruction with construction jobs.')  if !slot.jobs.empty? && slot.jobs.first.job_type != self.job_type && slot.jobs.first.job_type != TYPE_CREATE
    
    # test correct level
    return false if self.job_type == TYPE_CREATE    && (self.level_after != 1 || (!slot.level.nil? && slot.level != 0) || !slot.jobs.empty?)
    return false if self.job_type == TYPE_UPGRADE   && (self.level_after != slot.last_level + 1) # TODO when max_level available: || self.level_after > (slot.max_level || 10000))
    # return false if self.job_type == TYPE_DOWNGRADE && (self.level_after != slot.last_level - 1 || self.level_after < 0)   # not yet implemented
    return false if self.job_type == TYPE_DESTROY   && (slot.last_level.nil?  || slot.last_level == 0)
    
    # test if building ability is unlocked in settlement
    return false unless settlement.settlement_queue_buildings_unlock_count > 0    # THIS IS AN ERROR: there are queues of other types (e.g. fortification)! either the client should post to the queue or you must search the correct (queue_type that is unlocked and able to build the building category of the building) queue here
    
    # TODO test if building_id valid
    
    # TODO test if building can be build in slot according to the slots building categories
    
    # TODO forgot anything to test? 
    
    # test correct building id
    return false if !slot.level.nil? && slot.level != 0 && self.building_id != slot.building_id
    
    true
  end
  
  # checks if user owns enough resources for job and reduces them instantly
  def pay_for_job
    self.slot.settlement.owner.resource_pool.remove_resources_transaction(self.costs)
  end
  
  def refund_for_job
    self.slot.settlement.owner.resource_pool.add_resources_transaction(self.costs)
  end
  
  def finish
    slot = self.slot
    
    if self.job_type == 'create'
      if slot.empty?
        # TODO check requirements like enough resources 

        slot.create_building(self.building_id)
      else
        raise ForbiddenError.new('slot is not empty')
      end        
    elsif self.job_type == 'upgrade'
      if !slot.empty?
        # TODO check requirements like enough resources 
        
        slot.upgrade_building
      else
        raise ForbiddenError.new('slot is empty')
      end        
    elsif self.job_type == 'downgrade'
      if !slot.empty?
        # TODO check requirements like enough resources 
        
        slot.downgrade_building
      else
        raise ForbiddenError.new('slot is empty')
      end        
    elsif self.job_type == 'destroy'
      if !slot.empty?
        # TODO check requirements like enough resources 
        
        slot.destroy_building
      else
        raise ForbiddenError.new('slot is empty')
      end        
    end
  end
  
end
