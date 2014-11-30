require 'npc_ai/runloop'

class NpcAi::MovementHandler
  
  def runloop 
    return @runloop
  end
  
  def runloop=(arg)
    @runloop = arg
  end
  
  def notification_type
    "npc_movement"
  end
  
  def daytime?(date)
    return false       if date.nil?
    
    beginning_of_night = date.end_of_day       - 1.hours
    end_of_night       = date.beginning_of_day + 8.hours
    
    date > end_of_night && date < beginning_of_night
  end
  
  # This submodules moves Neanderthal's armies randomly around the map.
  # NPC armies may go to any location, but clearly prefer to visit 
  # fortress locations of players with an alliance membership. With some
  # probability, NPC armies may attack fortresses owned by human players.
  # 
  # NPC armies do rest during night hours (according to UTC).
  def process
    runloop.say "NPC AI submodule movement handler started"
    
    if daytime?(DateTime.now)

      days_since_start  = Fundamental::RoundInfo.the_round_info.age
      max_movement      = 0.1  # maximum percentage of neanderthals moving at the same time
      max_batch_size    = 25

      target_percentage = [max_movement, days_since_start * 0.001].min
    
      num_candidates    = Military::Army.ai_action_candidates.count
      num_moving        = Military::Army.npc.non_garrison.moving.count
    
      num_start_to_move = (num_candidates * target_percentage - num_moving).to_i
    
      if (num_start_to_move > 0)
        runloop.say "NPC AI: should move #{ num_start_to_move} npc armies."
      
        armies = Military::Army.ai_action_candidates_with_limit([max_batch_size, num_start_to_move].min)
        armies.each do |army|
          if !army.nil? && army.owned_by_npc? && !army.garrison?  # just to protect against buggy selector. never move player armies.
            army.ai_act   
            runloop.say "NPC AI: move army with id #{ army.id }."
          else
            runloop.say "NPC AI: ERROR: should move army with id #{ army.nil? ? 'nil' : army.id }, but it's not moveable."
          end
        end
      else
        runloop.say "NPC AI: nothing to do."
      end
      
    else
      runloop.say "NPC AI: npc armies do rest during the night."
    end

    runloop.say "NPC AI submodule movement handler completed"
  end
end

