class Construction::Queue < ActiveRecord::Base

  belongs_to :settlement,  :class_name => "Settlement::Settlement",  :foreign_key => "settlement_id", :inverse_of => :queues

  has_many   :jobs,        :class_name => "Construction::Job",       :foreign_key => "queue_id",      :inverse_of => :queue,   :order => 'position ASC'
  has_many   :active_jobs, :class_name => "Construction::ActiveJob", :foreign_key => "queue_id",      :inverse_of => :queue
  
  before_save :update_speed
  
  # checks if there are unused threads in this queue and if there
  # is a new job to execute in  this thread. In this case a new active job
  # is created. Recursive invokation for testing another thread.
  def check_for_new_jobs
    # if there are less active jobs than the number of threads to handle a job 
    active_jobs = self.jobs.select{ |job| job.active? }
    if active_jobs.count < self.threads
      # if there are inactive jobs
      queued_jobs = self.jobs.select{ |job| !job.active? }
      if !queued_jobs.empty?
        # create active job 
        next_job = queued_jobs.first
        active_job = next_job.build_active_job
        active_job.queue = self
        active_job.started_at = Time.now
        active_job.finished_at = Time.now + next_job.building_time
        next_job.save
        
        # test again
        self.check_for_new_jobs
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

  protected

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
      self.speed = 1.0 + self.speedup_buildings + self.speedup_sciences + self.speedup_alliance + self.speedup_effects
    end

end
