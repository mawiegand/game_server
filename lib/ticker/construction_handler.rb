require 'ticker/runloop'

class Ticker::ConstructionHandler
  
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
      runloop.say "Could not find battle for id #{ event.local_event_id }.", Logger::ERROR
    else
      runloop.say "Process active construction job #{ active_job.job_id } type '#{ active_job.job_type }' in settlement #{ active_job.queue.settlement_id }"
      
      # construction code

      active_job.job.destroy
      active_job.destroy
      event.destroy
      runloop.say "Construction handler completed."
    end
  end
end






