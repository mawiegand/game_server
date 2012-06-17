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
      
      unless event.character == settlement.owner
        runloop.say "Job creator is not settlement owner in job '#{ job.id }'.", Logger::ERROR
        job.destroy
        return
      end 
      
      # runloop.say "1"

      # construction code
      if job.job_type == 'create'
        # runloop.say "2"
        if slot.empty?
          # TODO check requirements like enough resources 
          # runloop.say "3"

          slot.create_building(job.building_id)
          # runloop.say "4"
        else
          runloop.say "Could not create building, slot id #{ slot.id } is not empty", Logger::ERROR
        end        
      elsif job.job_type == 'upgrade'
        if !slot.empty?
          # TODO check requirements like enough resources 
          
          slot.upgrade_building
        else
          runloop.say "Could not upgrade building, slot id #{ slot.id } is empty", Logger::ERROR
        end        
      elsif job.job_type == 'downgrade'
        if !slot.empty?
          # TODO check requirements like enough resources 
          
          slot.downgrade_building
        else
          runloop.say "Could not destroy building, slot id #{ slot.id } is empty", Logger::ERROR
        end        
      elsif job.job_type == 'destroy'
        if !slot.empty?
          # TODO check requirements like enough resources 
          
          slot.destroy_building
        else
          runloop.say "Could not destroy building, slot id #{ slot.id } is empty", Logger::ERROR
        end        
      end
      
      queue = job.queue
      
      job.destroy
      # active_job.destroy   # will be automatically destroyed due to dependencies between models
      # event.destroy
      
      if queue
        queue.check_for_new_jobs
      else
        runloop.say "Invalid job type '#{ job.job_type }'.", Logger::ERROR
      end

      runloop.say "Construction active job handler completed."
    end
  end
end






