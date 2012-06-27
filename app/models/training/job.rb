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
      costs[resource_id] = (self.quantity - self.quantity_finished) * f.apply()
    end
    return costs
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
    
    # test if garrison army is unlocked
    return false unless settlement.settlement_unlock_garrison_count > 0
    
    # test if army category is unlocked
    # TODO testen!
    category = rules.unit_categories[rules.unit_types[self.unit_id][:category]][:symbolic_id]
    logger.debug 'settlement_queue_' + category = '_unlock_count'
    logger.debug settlement['settlement_queue_' + category = '_unlock_count'].inspect
    return false unless settlement['settlement_queue_' + category = '_unlock_count'] > 0

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
  
  # creates the units for tha active job. if there are more units to be build in this job, 
  # active job will be updated and a new event is created
  def create_units
    # units bauen
    active_job = self.active_job
    queue = self.queue
    
    queue.settlement.add_units_to_garrison(self.unit_id, active_job.quantity_active)
    quantity_remaining = self.quantity - self.quantity_finished - active_job.quantity_active
    quantity_next = [queue.threads, quantity_remaining].min
    
    if quantity_remaining > 0
      # job aktualisieren
      self.quantity_finished += active_job.quantity_active
      # active_job aktualisieren
      active_job.quantity_active = quantity_next
      new_start = active_job.finished_active_at
      active_job.started_active_at = new_start
      active_job.finished_active_at = new_start + (self.training_time / queue.speed)
      active_job.event.destroy
      self.save
      
      active_job.create_ticker_event      
    else
      # job wegräumen
      self.destroy
    end
  end
  
end
