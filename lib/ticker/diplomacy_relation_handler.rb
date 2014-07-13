require 'ticker/runloop'

class Ticker::DiplomacyRelationHandler
  
  def runloop 
    return @runloop
  end
  
  def runloop=(arg)
    @runloop = arg
  end
  
  def event_type
    "diplomacy_relation"
  end
  
  def process_event(event)
    relation = Fundamental::DiplomacyRelation.find(event.local_event_id)
    
    if relation.nil?
      runloop.say "Could not find diplomacy relation for id #{ event.local_event_id }.", Logger::ERROR
      return
    else
      relation.next_status
      runloop.say "Diplomacy Relation handler completed."
    end
  end
end

