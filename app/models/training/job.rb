require 'util/formula'
require 'game_state/requirements'

class Training::Job < ActiveRecord::Base
  
  has_one    :active_job,  :class_name => "Training::ActiveJob", :foreign_key => "job_id",    :inverse_of => :job, :dependent => :destroy
  
  belongs_to :queue,       :class_name => "Training::Queue",     :foreign_key => "queue_id",  :inverse_of => :jobs,  :counter_cache => true, :touch => true
  
  def active?
    !self.active_job.nil?
  end
  
  def training_time
    rules = GameRules::Rules.the_rules
    formula = Util::Formula.parse_from_formula(rules.unit_types[self.unit_id][:production_time])
    formula.apply()
  end
  
  def costs
    unitType = GameRules::Rules.the_rules.unit_types[self.unit_id]
    return {} if unitType[:costs].nil?
    costs = {}
    unitType[:costs].each do |resource_id, formula|
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
    queue = self.queue
    settlement = queue.settlement
    owner = settlement.owner
    
    # get requirements from rules
    rules = GameRules::Rules.the_rules
    requirements = rules.unit_types[self.unit_id][:requirements]
    
    # test if requirements are met
    return false if !requirements.nil? && !requirements.empty? && !GameState::Requirements.meet_requirements?(requirements, owner, settlement) 

    # test if queue is already full   
    return false if self.queue && self.queue.max_length <= self.queue.jobs_count
    
    true
  end
  
  # checks if user owns enough resources for job and reduces them instantly
  def pay_for_job
    self.queue.settlement.owner.resource_pool.remove_resources_transaction(self.costs)
  end
  
  def refund_for_job
    self.queue.settlement.owner.resource_pool.add_resources_transaction(self.costs)
  end
  
end
