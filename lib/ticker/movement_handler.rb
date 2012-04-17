require 'ticker/runloop'

class Ticker::MovementHandler
  
  def runloop 
    return @runloop
  end
  
  def runloop=(arg)
    @runloop = arg
  end
  
  def event_type
    "action_military_move_army_action"
  end
  
  def process_event(event)
    action = Action::Military::MoveArmyAction.find(event.local_event_id)
    if action.nil?
      runloop.say "Could not find movement action for id #{ event.local_event_id }.", Logger::ERROR
    else
      runloop.say "Process movement action #{ action.id } moving army #{ action.army_id } from loc #{ action.starting_location_id} in reg #{ action.starting_region_id } to loc #{ action.target_location_id } in reg #{ action.target_region_id }"
      
      if action.army.nil? 
        runloop.say "Could not find army #{ action.army_id }.", Logger::ERROR
        return ;
      elsif action.army.location_id != action.starting_location_id
        runloop.say "Army #{ action.army_id } is at loc #{ action.army.location_id } but it was expected to be at loc #{ action.starting_location_id }.", Logger::ERROR
        return ;
      end
      
      action.army.location_id = action.target_location_id  
      action.army.region_id = action.target_region_id  
      action.army.target_location = nil
      action.army.target_region = nil
      action.army.target_reached_at = nil
      action.army.mode = 0
      
      if !action.army.save
        runloop.say "Army #{action.army_id} could not be moved to new location. Save did fail.", Logger::ERROR
        return
      end
      runloop.say "Movement completed, cleaning up and destroying event."      
      action.region.armies_changed_at = DateTime.now
      action.region.save
      action.location.armies_changed_at = DateTime.now
      action.location.save
      action.destroy
      event.destroy
      runloop.say "Movement handler completed."
    end
  end
end

