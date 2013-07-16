require 'ticker/runloop'

class Ticker::SpecialAssignmentHandler
  
  def runloop 
    return @runloop 
  end
  
  def runloop=(arg)
    @runloop = arg
  end
  
  def event_type
    "special_assignment"
  end
  
  def process_event(event)
    assignment = Assignment::SpecialAssignment.find(event.local_event_id)
    
    if assignment.nil?
      runloop.say "Could not find special assignment for id #{ event.local_event_id }.", Logger::ERROR
      return
    else
      if !assignment.ongoing? 
        runloop.say "Special assignment with id #{ assignment.id } wasn't ongoing.", Logger::ERROR
        return
      end
      
      runloop.say "Process special assignment #{ assignment.id } of character #{ assignment.character.id }"
  
      assignment.redeem_rewards_deposit_and_end_transaction
            
      # event.destroy unless event.nil?
      runloop.say "Special assignment handler completed."
    end
  end
end






