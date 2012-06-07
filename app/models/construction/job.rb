require 'util/formula'

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
  
  def last_in_slot
    self == self.queue.sorted_jobs_for_slot(self.slot).last
  end
  
  # checks if a job can be queueable due to requirements like e.g. building levels
  def queueable?
    
    # slot = Settlement::Slot.find(self.slot_id)
    slot = self.slot
    
    logger.debug slot.inspect
    logger.debug slot.jobs.inspect
    
    
    # same job type if queue has already jobs
    return false if !slot.jobs.empty? && slot.jobs.first.job_type != self.job_type
    
    # correct level
    return false if self.job_type == TYPE_CREATE && self.slot.last_level != 1
    return false if self.job_type == TYPE_UPGRADE && self.level_after != self.slot.last_level + 1
    return false if self.job_type == TYPE_DOWNGRADE && self.level_after != self.slot.last_level - 1
    return false if self.job_type == TYPE_DESTROY && (self.slot.last_level != 0 || !self.slot.last_level.nil?)
    
    # correct building id
    return false if self.building_id != slot.building_id
    
    true
  end
  
  # checks if user owns enough resources for job and reduces them instantly
  def reduce_ressources
    true
  end
  
end
