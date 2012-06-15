 require 'ticker/runloop'

class Ticker::ConstructionQueueCheckHandler
  
  def runloop 
    return @runloop 
  end
  
  def runloop=(arg)
    @runloop = arg
  end
  
  def event_type
    "construction_queue_check"
  end
  
  def process_event(event)
    queue = Construction::Queue.find(event.local_event_id)
    if queue.nil?
      runloop.say "Could not find queue for id #{ event.local_event_id }.", Logger::ERROR
      return
    else
      queue.check_for_new_jobs
      event.destroy
      
      runloop.say "Construction queue check handler completed."
    end
  end
end






