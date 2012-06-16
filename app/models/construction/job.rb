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
    formula.apply(self.level_after)
  end
  
  def costs
    buildingType = GameRules::Rules.the_rules.building_types[self.building_id]
    return {} if buildingType[:costs].nil?
    costs = {}
    buildingType[:costs].each do |resource_id, formula|
      f = Util::Formula.parse_from_formula(formula)
      costs[resource_id] = f.apply(self.level_after)
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
    rules = GameRules::Rules.the_rules
    requirements = rules.building_types[self.building_id][:requirements]
    
    # test if requirements are met
    raise ForbiddenError.new('Requirements not met.')  if !requirements.nil? && !requirements.empty? && !GameState::Requirements.meet_requirements?(requirements, owner, settlement) 

    # test if queue is already full   
    raise ForbiddenError.new('Queue is already full.') if self.queue && self.queue.max_length <= (self.queue.jobs_count || 0)
    
    # test same job type if queue has already jobs
    raise ForbiddenError.new('Not allowed to mix destruction with construction jobs.')  if !slot.jobs.empty? && slot.jobs.first.job_type != self.job_type && slot.jobs.first.job_type != TYPE_CREATE
    
    # test correct level
    return false if self.job_type == TYPE_CREATE    && (self.level_after != 1 || (!slot.level.nil? && slot.level != 0) || !slot.jobs.empty?)
    return false if self.job_type == TYPE_UPGRADE   && (self.level_after != slot.last_level + 1) # TODO when max_level available: || self.level_after > (slot.max_level || 10000))
    return false if self.job_type == TYPE_DOWNGRADE && (self.level_after != slot.last_level - 1 || self.level_after < 0)
    return false if self.job_type == TYPE_DESTROY   && (slot.last_level.nil?  || slot.last_level != 0)
    
    # test correct building id
    return false if !slot.level.nil? && slot.level != 0 && self.building_id != slot.building_id
    
    true
  end
  
  # checks if user owns enough resources for job and reduces them instantly
  def pay_for_job
    self.slot.settlement.owner.resource_pool.remove_resources_transaction(self.costs)
  end
  
end
