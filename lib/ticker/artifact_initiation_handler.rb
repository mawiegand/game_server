require 'ticker/runloop'

class Ticker::ArtifactInitiationHandler
  
  def runloop 
    return @runloop 
  end
  
  def runloop=(arg)
    @runloop = arg
  end
  
  def event_type
    "artifact_initiation"
  end
  
  def process_event(event)
    initiation = Fundamental::ArtifactInitiation.find(event.local_event_id)
    if initiation.nil?
      runloop.say "Could not find initiation for id #{ event.local_event_id }.", Logger::ERROR
      return
    else
      initiation.finish
      runloop.say "Artifact initiation handler completed."
    end
  end
end






