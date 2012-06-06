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
  
end
