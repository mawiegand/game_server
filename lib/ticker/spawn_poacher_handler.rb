require 'ticker/runloop'

class Ticker::SpawnPoacherHandler
  
  def runloop 
    return @runloop
  end
  
  def runloop=(arg)
    @runloop = arg
  end
  
  def event_type
    "spawn_poacher"
  end
  
  def process_event(event)
    character = Fundamental::Character.find(event.local_event_id)

    if character.nil?
      runloop.say "Could not find character for id #{ event.local_event_id }.", Logger::ERROR
      return
    else
      character.update_poachers

      runloop.say "Spawn Poacher handler completed."
    end
  end
end

