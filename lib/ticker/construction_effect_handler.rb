require 'ticker/runloop'

class Ticker::ConstructionEffectHandler
  
  def runloop 
    return @runloop 
  end
  
  def runloop=(arg)
    @runloop = arg
  end
  
  def event_type
    "construction_effect"
  end
  
  def process_event(event)
    effect = Effect::ConstructionEffect.find(event.local_event_id)
    if effect.nil?
      runloop.say "Could not find effect for id #{ event.local_event_id }.", Logger::ERROR
      return
    end
    
    # event will be automatically destroyed by deleting the corresponding effect model
    effect.destroy
    
    runloop.say "Construction effect handler completed."
  end
end






