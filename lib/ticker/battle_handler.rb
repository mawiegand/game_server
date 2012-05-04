require 'ticker/runloop'

class Ticker::BattleHandler
  
  def runloop 
    return @runloop
  end
  
  def runloop=(arg)
    @runloop = arg
  end
  
  def event_type
    "military_battle"
  end
  
  def process_event(event)
    battle = Military::Battle.find(event.local_event_id)
    if battle.nil?
      runloop.say "Could not find battle for id #{ event.local_event_id }.", Logger::ERROR
    else
      runloop.say "Process battle round #{ battle.battle_rounds_count || 0} for battle #{ battle.id } at loc #{ battle.location_id} in reg #{ battle.region_id }."
    
      # FILL C++-BATTLE CLASS
      
      # EXECUTE ROUND
      
      # EXTRACT AND STORE RESULTS IN DATABASE
      #  EXTRACT RESULTS (FACTION AND PARTICIPANT RESULTS)
      #  CLEANUP KILLED ARMIES 
      #  LET ARMIES RETREAT AND CLEANUP PARTICIPANT AND ARMY
      
      # CONTINUE BATTLE?
      # YES: CREATE EVENT FOR NEXT ROUND
      # NO: CLEANUP PARTICIPANTS, FACTIONS AND BATTLE; RESET ARMIES
      
      
      runloop.say "Battle round completed, cleaning up and destroying event."      


      event.destroy
      runloop.say "Battle handler completed."
    end
  end
end

