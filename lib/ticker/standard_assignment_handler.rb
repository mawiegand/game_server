require 'ticker/runloop'

class Ticker::StandardAssignmentHandler
  
  def runloop 
    return @runloop 
  end
  
  def runloop=(arg)
    @runloop = arg
  end
  
  def event_type
    "standard_assignment"
  end
  
  def process_event(event)
    assignment = Assignment::StandardAssignment.find(event.local_event_id)
    
    if assignment.nil?
      runloop.say "Could not find standard assignment for id #{ event.local_event_id }.", Logger::ERROR
      return
    else
      if !assignment.ongoing? 
        runloop.say "Standard assignment with id #{ assignment.id } wasn't ongoing.", Logger::ERROR
        return
      end
      
      runloop.say "Process standard assignment #{ assignment.id } of character #{ assignment.character.id }"
  
      assignment.redeem_rewards_deposit_and_end_transaction
            
      # event.destroy unless event.nil?
      runloop.say "Standard assignment handler completed."
    end
  end
end






