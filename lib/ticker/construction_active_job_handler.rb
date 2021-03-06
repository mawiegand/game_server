require 'ticker/runloop'

class Ticker::ConstructionActiveJobHandler
  
  def runloop 
    return @runloop 
  end
  
  def runloop=(arg)
    @runloop = arg
  end
  
  def event_type
    "construction_active_job"
  end
  
  def process_event(event)
    active_job = Construction::ActiveJob.find(event.local_event_id)
    if active_job.nil?
      runloop.say "Could not find active_job for id #{ event.local_event_id }.", Logger::ERROR
      return
    else
      job = active_job.job
      if job.nil? 
        runloop.say "Could not find corresponding job for id #{ active_job.job_id }.", Logger::ERROR
        return
      end
      
      runloop.say "Process active construction job #{ active_job.job_id } type '#{ job.job_type }' in settlement #{ active_job.queue.settlement_id }"
      
      slot = job.slot 
      if slot.nil?
        runloop.say "No slot given for job '#{ job.id }'.", Logger::ERROR
        return
      end 
      
      settlement = slot.settlement 
      if settlement.nil?
        runloop.say "No settlement given for job '#{ job.id }'.", Logger::ERROR
        return
      end 
 
      # construction code
      job.finish
      
      queue = job.queue
      if queue.nil?
        runloop.say "No queue given for job '#{ job.id }'.", Logger::ERROR
        return
      end 
      
      job.destroy        # active_job and event will be automatically destroyed due to dependencies between models
      
      queue.check_for_new_jobs

      runloop.say "Construction active job handler completed."
    end
  end
end






