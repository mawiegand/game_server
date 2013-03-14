class Backend::TradeLogEntry < ActiveRecord::Base
  
  def self.create_with_trading_carts_action(action)
    entry = Backend::TradeLogEntry.new({
      sender_id:         action.sender.id,
      sender_name:       action.sender.name,
      recipient_id:      action.recipient.id,
      recipient_name:    action.recipient.name,
      sender_ip:         action.sender_ip,
      target_reached_at: action.target_reached_at,
      num_carts:         action.num_carts,
    })
    
    if !action.sender.alliance.nil?
      entry.sender_alliance_id      = action.sender.alliance.id
      entry.sender_alliance_name    = action.sender.alliance.name
    end
    if !action.recipient.alliance.nil?
      entry.recipient_alliance_id   = action.recipient.alliance.id
      entry.recipient_alliance_name = action.recipient.alliance.name
    end
        
    entry.attributes.each do |attribute, value| 
      if attribute.start_with?('resource_') && attribute.end_with?('_amount')
        entry[attribute] = action[attribute] || 0
      end
    end

    entry.save
  end
  
end
