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
      runloop.say "Could not find active_job for id #{ event.local_event_id }.", Logger::ERROR
      return
    else
      job = active_job.job
      if job.nil? 
        runloop.say "Could not find corresponding job for id #{ active_job.job_id }.", Logger::ERROR
        return
      end
      
      runloop.say "Process active construction job #{ active_job.job_id } type '#{ job.job_type }' in settlement #{ active_job.queue.settlement_id }"
      
      # construction code
      if job.job_type == 'create'
        runloop.say "Valid job type '#{ job.job_type }'.", Logger::ERROR
        
        slot = job.slot 
        runloop.say "No slot given for job '#{ job.id }'.", Logger::ERROR if slot.nil?
        
        if slot.empty?
          
          # TODO check requirements like enough resources 
          
          slot.create_building(job.building_id)
        else
          runloop.say "Could not create building, slot id #{ slot.id } is not empty", Logger::ERROR
        end
        
      elsif job.job_type == 'upgrade'
        runloop.say "Valid job type '#{ job.job_type }'.", Logger::ERROR
      elsif job.job_type == 'downgrade'
        runloop.say "Valid job type '#{ job.job_type }'.", Logger::ERROR
      elsif job.job_type == 'destroy'
        runloop.say "Valid job type '#{ job.job_type }'.", Logger::ERROR
      else
        runloop.say "Invalid job type '#{ job.job_type }'.", Logger::ERROR
        return
      end
      
      queue = job.queue
      
      active_job.job.destroy
      active_job.destroy
      event.destroy
      
      if queue
        queue.check_for_new_jobs
      else
        runloop.say "Invalid job type '#{ job.job_type }'.", Logger::ERROR
      end

      runloop.say "Construction handler completed."
    end
  end
end






