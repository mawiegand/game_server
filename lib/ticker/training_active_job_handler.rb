require 'ticker/runloop'

class Ticker::TrainingActiveJobHandler
  
  def runloop 
    return @runloop 
  end
  
  def runloop=(arg)
    @runloop = arg
  end
  
  def event_type
    "training_active_job"
  end
  
  def process_event(event)
    active_job = Training::ActiveJob.find(event.local_event_id)
    if active_job.nil?
      runloop.say "Could not find active_job for id #{ event.local_event_id }.", Logger::ERROR
      return
    else
      job = active_job.job
      if job.nil? 
        runloop.say "Could not find corresponding job for id #{ active_job.job_id }.", Logger::ERROR
        return
      end
      
      runloop.say "Process active training job #{ active_job.job_id } in settlement #{ active_job.queue.settlement_id }"
      
      queue = job.queue
      if queue.nil?
        runloop.say "No queue given for job '#{ job.id }'.", Logger::ERROR
        return
      end 
      
      settlement = queue.settlement 
      if settlement.nil?
        runloop.say "No settlement given for job '#{ job.id }'.", Logger::ERROR
        return
      end 
      
      unless event.character == settlement.owner ## TODO: Takeover? -> this may happen!
        runloop.say "Job creator is not settlement owner in job '#{ job.id }'.", Logger::ERROR
        job.destroy
        return
      end 
      
      runloop.say "Now create units for job #{ job.inspect }"
      
      # update active job and create new event, if more unit are to build
      job.add_finished_units
      
      runloop.say "Check for new jobs"
      
      # job will be destroyed in all units of the job are trained. Therefore check if 
      # the current job is either nil or frozen before checking for a new job
      queue.check_for_new_jobs if job.nil? || job.frozen?
      
      # event.destroy unless event.nil?
      runloop.say "Training active job handler completed."
    end
  end
end






