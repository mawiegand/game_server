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
    rules.unit_types[self.unit_id][:production_time].to_i / (self.hurried? ? 2 : 1)
  end
  
  def costs
    unitType = GameRules::Rules.the_rules.unit_types[self.unit_id]
    return {} if unitType[:costs].nil?
    costs = {}
    unitType[:costs].each do |resource_id, quantity_per_unit|
      costs[resource_id] = (self.quantity - self.quantity_finished) * quantity_per_unit.to_i
    end
    return costs
  end
  
  # checks if a job can be queueable due to requirements like e.g. building levels
  def queueable?
    queue = self.queue
    settlement = queue.settlement
    owner = settlement.owner
    
    logger.debug "TRAINING JOB QUEUEABLE?"
    
    # get requirements from rules
    rules = GameRules::Rules.the_rules
    requirements = rules.unit_types[self.unit_id][:requirements]
    
    return false  if !rules.unit_types[self.unit_id][:trainable]
    
    logger.debug "REQ #{requirements}, TRAINABLE #{ rules.unit_types[self.unit_id][:trainable] }."
    
    # test if requirements are met
    return false if !requirements.nil? && !requirements.empty? && !GameState::Requirements.meet_requirements?(requirements, owner, settlement)
    
    logger.debug "UNLOCK COUNT #{settlement.settlement_unlock_garrison_count}"
    
    # test if garrison army is unlocked
    return false unless settlement.settlement_unlock_garrison_count > 0
    
    # test if army category is unlocked
    # TODO testen!   WHY? If the queue is there, it's unlocked, right?! Test, whether the unit's category is within the building-options (list of categories) 
    # category = rules.unit_categories[rules.unit_types[self.unit_id][:category]][:symbolic_id]
    # logger.debug 'settlement_queue_' + category.to_s + '_unlock_count'
    # logger.debug settlement['settlement_queue_' + category.to_s + '_unlock_count'].inspect
    # return false unless settlement['settlement_queue_' + category.to_s + '_unlock_count'] > 0
    unit_category = rules.unit_categories[rules.unit_types[self.unit_id][:category]][:id]
    queue_type = rules.queue_types[self.queue.type_id]
    
    produceable = false
    queue_type[:produces].each { |id| produceable ||= unit_category == id }
    raise BadRequestError.new('Can not produce this type of unit in the given queue.') unless produceable

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
  
  def speedup
    self.hurried = true  # this job is hurried

    if self.active_job.nil?
      logger.warn "Hurried a training event that is not the active event. Presently, this is against the game rules."
    else
      self.active_job.event.destroy 
      
      start = self.active_job.started_active_at
      active_job.finished_active_at = start + (self.training_time / queue.speed)
      active_job.finished_total_at  = start + ((1.0 * quantity_remaining / self.threads).ceil * self.training_time / self.speed)

      self.active_job.create_ticker_event
    end
    
    self.save            # should also save active_job...
  end
    
    
  
  # creates the units for tha active job. if there are more units to be build in this job, 
  # active job will be updated and a new event is created
  # if there is not enough space in the garrison army, only those units which fit into the garrison
  # army will be created and the overpaid resources will be refunded
  def add_finished_units
    active_job = self.active_job
    queue = self.queue
    
    units_to_add = active_job.quantity_active
    added_units = queue.settlement.add_units_to_garrison(self.unit_id, units_to_add)
        
    quantity_remaining = self.quantity - self.quantity_finished - added_units
    quantity_next = [queue.threads, quantity_remaining].min
    
    if quantity_remaining > 0
      # if the garrison army is full, stop active job
      if queue.settlement.garrison_army.full?
        # destroy active job
        active_job.destroy
        # job aktualisieren
        self.quantity_finished += added_units
        # refund resources for units not created yet
        self.refund_for_job
        self.save
        # queue check event erzeugen
        queue.create_queue_check_event
      else
        # job aktualisieren
        self.quantity_finished += active_job.quantity_active
        # active_job aktualisieren
        active_job.quantity_active = quantity_next
        new_start = active_job.finished_active_at
        active_job.started_active_at = new_start
        active_job.finished_active_at = new_start + (self.training_time / queue.speed)
        active_job.finished_total_at  = new_start + ((1.0 * quantity_remaining / self.threads).ceil * self.training_time / self.speed)

        active_job.event.destroy
        self.save
        
        active_job.create_ticker_event
      end      
    else
      # job wegräumen
      self.destroy
    end
  end
  
end
