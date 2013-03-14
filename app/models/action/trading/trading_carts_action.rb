class Action::Trading::TradingCartsAction < ActiveRecord::Base

  belongs_to :starting_settlement, :class_name => "Settlement::Settlement", :foreign_key => "starting_settlement_id", :inverse_of => :outgoing_trading_carts
  belongs_to :target_settlement,   :class_name => "Settlement::Settlement", :foreign_key => "target_settlement_id",   :inverse_of => :incoming_trading_carts  
  belongs_to :sender,              :class_name => "Fundamental::Character", :foreign_key => "sender_id" 
  belongs_to :recipient,           :class_name => "Fundamental::Character", :foreign_key => "recipient_id" 

  has_one    :event,               :class_name => "Event::Event",           :foreign_key => "local_event_id",         :dependent => :destroy, :conditions => "event_type = 'trading_carts_action'"
  
  after_destroy  :release_carts

  def speedup
    unless self.returning?
      unless self.send_hurried?
        self.send_hurried = true                                                         # sending is hurried
        self.event.destroy                                                               # destroy event
        self.returned_at -= 30.minutes
        self.target_reached_at -= 30.minutes                                             # reduce time
        self.create_event                                                                # create new ticker event
        self.save
      else
        self.event.destroy                                                               # destroy event
        self.returned_at -= (self.target_reached_at - Time.now)
        self.target_reached_at = Time.now                                                # reduce time
        self.create_event                                                                # create new ticker event
        self.save
      end
    else
      unless self.return_hurried?
        self.return_hurried = true                                                       # sending is hurried
        self.event.destroy                                                               # destroy event
        self.returned_at -= 30.minutes                                                   # reduce time
        self.create_event                                                                # create new ticker event
        self.save
      else
        self.event.destroy                                                               # destroy event
        self.returned_at = Time.now                                                      # reduce time
        self.create_event                                                                # create new ticker event
        self.save
      end
    end
  end
 
  def create_event
    #create entry for event table
    new_event = self.build_event(
      character_id:   self.sender_id,   # get current character id
      execute_at:     self.returning? ? self.returned_at : self.target_reached_at,
      event_type:     "trading_carts_action",
      local_event_id: self.id,
    )
    if !new_event.save 
      raise ArgumentError.new('could not create event for trading carts action')
    end
  end
  
  def return 
    return false if self.returning
#   self.returned_at       = self.reached_target_at + (self.reached_target_at - self.created_at)
    self.returning         = true
  end
  
  def cancel_transaction
    return false    if self.returning
    
    now = Time.now
    success = false

    ActiveRecord::Base.transaction(:requires_new => true) do
      self.event.lock!       unless self.event.nil?
      self.lock!
      
      return false           if self.returning              # just check twice, because event handler or another process might just have changed this   
    
      self.returned_at       = now + (now - self.created_at)
      self.returning         = true
    
      if (!self.event.nil?)
        self.event.destroy               
        raise ActiveRecord::Rollback   unless self.event.frozen?
      end
      self.save! 
      self.create_event
      success = true
    end
    
    return success
  end
  
  def resources
    @resources = {}

    GameRules::Rules.the_rules().resource_types.each do |resource_type|
      field_name = resource_type[:symbolic_id].to_s() + '_amount'
      @resources[resource_type[:id]] = self[field_name]    unless self[field_name].blank? 
    end    

    @resources     
  end
  
  def reset_resources
    GameRules::Rules.the_rules().resource_types.each do |resource_type|
      field_name = resource_type[:symbolic_id].to_s() + '_amount'
      self[field_name] = 0   unless self[field_name].blank? 
    end     
  end
  
  def total_resources
    total = 0
    GameRules::Rules.the_rules().resource_types.each do |resource_type|
      total += self[resource_type[:symbolic_id].to_s() + '_amount'] || 0
    end     
    total
  end
  
  def empty?
    return total_resources <= 0
  end
  
  def load_resources
    self.starting_settlement.owner.resource_pool.remove_resources_transaction(self.resources)
  end
  
  def unload_resources_at_target
    self.target_settlement.owner.resource_pool.add_resources_transaction(self.resources)
    reset_resources
  end
  
  def unload_resources_at_origin
    self.starting_settlement.owner.resource_pool.add_resources_transaction(self.resources)
    reset_resources
  end  
  
  def carts_needed
    return (self.total_resources / 10.0).ceil
  end
  
  
  private  
  
    def release_carts
      return true  if self.starting_settlement_id.blank? || self.num_carts.blank?
      Settlement::Settlement.update_all(["trading_carts_used = trading_carts_used - ?, updated_at = ?", self.num_carts, Time.now], id: self.starting_settlement_id )   # atomic update, no lock necessary
    end

  
end
