require 'ticker/runloop'

class Ticker::TradingCartsActionHandler
  
  def runloop 
    return @runloop 
  end
  
  def runloop=(arg)
    @runloop = arg
  end
  
  def event_type
    "trading_carts_action"
  end
  
  def return_carts(action)
    runloop.say "Returning carts and recreating events."
    action.return
    action.save!
    action.event.destroy
    action.create_event
  end 

  
  def process_event(event)
    
    ActiveRecord::Base.transaction(:requires_new => true) do
      event.lock!
      action = Action::Trading::TradingCartsAction.find(event.local_event_id, :lock => true)
    
      if action.nil?
        runloop.say "Could not find trading carts action with id #{ event.local_event_id }.", Logger::ERROR
        return
      end
      
      if action.returning?
        runloop.say "Process returning trading carts #{ action.id } of settlement #{ action.starting_settlement_id }. Returned."        
        return_message = Messaging::Message.generate_trade_return_message(action)             
        if action.empty?
          runloop.say "No resources to unload."
        else
          runloop.say "Unloading resources at origin."     
          action.unload_resources_at_origin
        end
        return_message.save            
        runloop.say "Destroy the action and release trading carts."        
        action.destroy   # also deletes event and releases trading carts   
      else 
        runloop.say "Process arriving trading carts #{ action.id } at settlement #{ action.target_settlement_id }. Target reached."
        if action.target_settlement.nil? 
          runloop.say "Target settlement is gone: #{ action.inspect }.", Logger::INFO
        elsif action.target_settlement.owner_id != action.recipient_id
          runloop.say "Owner of target settlement has changed: #{ action.recipient_id } != #{ action.target_settlement.owner_id }.", Logger::INFO
        elsif action.empty?
          runloop.say "No resources to unload."
        else
          runloop.say "Unloading resources at target."
          Backend::TradeLogEntry.create_with_trading_carts_action(action)
          recipient_message = Messaging::Message.generate_trade_recipient_message(action)          
          sender_message = Messaging::Message.generate_trade_sender_message(action)          
          action.unload_resources_at_target
          recipient_message.save
          sender_message.save
        end
        
        return_carts(action)     # also recreates the events appropriately   
      end

      runloop.say "Reached end of transaction."      
    end
    runloop.say "Trading carts action handler completed."    
  end
end






