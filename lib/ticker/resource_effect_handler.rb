require 'ticker/runloop'

class Ticker::ResourceEffectHandler
  
  def runloop 
    return @runloop 
  end
  
  def runloop=(arg)
    @runloop = arg
  end
  
  def event_type
    "resource_effect"
  end
  
  def process_event(event)
    effect = Effect::ResourceEffect.find(event.local_event_id)
    if effect.nil?
      runloop.say "Could not find effect for id #{ event.local_event_id }.", Logger::ERROR
      return
    end
    
    # event will be automatically destroyed by deleting the corresponding effect model
    event.character.resource_pool.remove_effect_transaction(effect)
    
    runloop.say "Resource effect handler completed."
  end
end






