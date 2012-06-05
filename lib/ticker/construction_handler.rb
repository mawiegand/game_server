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
      
      slot = job.slot 
      if slot.nil?
        runloop.say "No slot given for job '#{ job.id }'.", Logger::ERROR
        return
      end 
      
      # construction code
      if job.job_type == 'create'
        if slot.empty?
          # TODO check requirements like enough resources 
          
          slot.create_building(job.building_id)
        else
          runloop.say "Could not create building, slot id #{ slot.id } is not empty", Logger::ERROR
        end        
      elsif job.job_type == 'upgrade'
        if !slot.empty?
          # TODO check requirements like enough resources 
          
          slot.upgrade_building(job.building_id)
        else
          runloop.say "Could not upgrade building, slot id #{ slot.id } is empty", Logger::ERROR
        end        
      elsif job.job_type == 'downgrade'
        if !slot.empty?
          # TODO check requirements like enough resources 
          
          slot.downgrade_building(job.building_id)
        else
          runloop.say "Could not destroy building, slot id #{ slot.id } is empty", Logger::ERROR
        end        
      elsif job.job_type == 'destroy'
        if !slot.empty?
          # TODO check requirements like enough resources 
          
          slot.destroy_building(job.building_id)
        else
          runloop.say "Could not destroy building, slot id #{ slot.id } is empty", Logger::ERROR
        end        
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






