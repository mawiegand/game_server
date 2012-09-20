class Training::Queue < ActiveRecord::Base
  
  belongs_to  :settlement,  :class_name => "Settlement::Settlement",  :foreign_key => "settlement_id", :inverse_of => :training_queues

  has_many   :jobs,        :class_name => "Training::Job",       :foreign_key => "queue_id",      :inverse_of => :queue,   :order => 'position ASC'
  has_many   :active_jobs, :class_name => "Training::ActiveJob", :foreign_key => "queue_id",      :inverse_of => :queue
  
  before_save :update_speed
  
  def working?
    aj = find_active_jobs
    !aj.nil? && aj.count > 0
  end
  
  def find_active_jobs
    self.jobs.select{ |job| job.active? }
  end  
  
  # checks if there are unused threads in this queue and if there
  # is a new job to execute in this thread. In this case a new active job
  # is created, if there are enough resources to pay the job. Otherwise, an
  # event is created to check again after a specific time.
  # Recursive invocation for testing another thread.
  def check_for_new_jobs
    
    # if there are less active jobs than the number of threads to handle a job 
    active_jobs = find_active_jobs
    # logger.debug '--> active_jobs ' + active_jobs.inspect
    if active_jobs.count < 1   # TODO should be 'self.threads', if more than one thread become available for users
      # if there are inactive jobs
      queued_jobs = self.jobs.select{ |job| !job.active? }
      # logger.debug '--> queued_jobs ' + queued_jobs.inspect
      if !queued_jobs.empty?
        # create active job 
        next_job = queued_jobs.first
        # test if job can be payed
        if !self.settlement.garrison_army.full? && next_job.pay_for_job
          active_job = next_job.build_active_job
          active_job.queue = self
          
          now = Time.now
          quantity_active = [next_job.quantity, self.threads].min
          
          active_job.quantity_active = quantity_active
          active_job.started_active_at = now
          active_job.finished_active_at = now + (next_job.training_time / self.speed)
          
          active_job.started_total_at = now
          active_job.finished_total_at = now + ((1.0 * next_job.quantity / self.threads).ceil * next_job.training_time / self.speed)
          
          next_job.save
          
          self.create_event_for_job(active_job)
        else
          # create event for next queue check
          self.create_queue_check_event
        end
      end
    end
    
    # don't let the position numbers get to large
    self.reset_job_positions
  end
  
  def max_position
    if self.jobs.empty?
      return 0
    else
      self.jobs.last.position
    end
  end
  
  def add_speedup(origin_type, delta)
    if origin_type    == :building
      self.speedup_buildings = self.speedup_buildings + delta
    elsif origin_type == :sciences
      self.speedup_sciences = self.speedup_sciences + delta
    elsif origin_type == :alliance
      self.speedup_alliance = self.speedup_alliance + delta
    elsif origin_type == :effects
      self.speedup_effects = self.speedup_effects + delta
    else 
      raise InternalServerError.new('Could not add speedup bonus of type #{origin_type.to_s}.');
    end
  end
  
  def sorted_jobs_for_slot(slot)
    jobs = self.jobs.select{ |job| job.slot == slot }
    jobs.sort_by(&:position)
  end

  def create_queue_check_event
    # check if there are already current check events for this queue
    if Event::Event.where(event_type: :training_queue_check, local_event_id: self.id, locked_at: nil).empty?
      #create entry for event table
      new_event = Event::Event.new(
          character_id: self.settlement.owner_id,   # get current character id
          execute_at: DateTime.now.advance(:minutes => 2),
          event_type: :training_queue_check,
          local_event_id: self.id,                  # queue id as local event id
      )
      if !new_event.save  # this is the final step; this makes sure, something is actually executed
        raise ArgumentError.new('could not create event for training queue check')
      end
    end
  end

  protected
  
    def create_event_for_job(active_job)
      #create entry for event table
      event = active_job.build_event(
          character_id: self.settlement.owner_id,   # get current character id
          execute_at: active_job.finished_active_at,
          event_type: "training_active_job",
          local_event_id: active_job.id,
      )
      if !active_job.save  # this is the final step; this makes sure, something is actually executed
        raise ArgumentError.new('could not create event for active training job')
      end
    end
  
    def reset_job_positions
      if !self.jobs.empty? && self.jobs.last.position > 1000
        ActiveRecord::Base.transaction do
          self.jobs.each do |job|
            job.position -= 1000
            job.save
          end
        end
      end
    end

    def update_speed
      sum = 1.0 + self.speedup_buildings + self.speedup_sciences + self.speedup_alliance + self.speedup_effects
      self.speed = sum < 0.00001 ? 0.00001 : sum
    end

end
