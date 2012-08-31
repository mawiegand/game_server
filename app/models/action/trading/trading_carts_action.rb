class Action::Trading::TradingCartsAction < ActiveRecord::Base
  
  belongs_to :starting_settlement, :class_name => "Settlement::Settlement", :foreign_key => "starting_settlement_id", :inverse_of => :outgoing_trading_carts
  belongs_to :target_settlement,   :class_name => "Settlement::Settlement", :foreign_key => "target_settlement_id",   :inverse_of => :incoming_trading_carts  
  
  after_destroy  :release_carts
  
  def cancel_transaction
    return false    if self.returning
    
    now = Time.now
    
    self.returned_at       = now + (now - self.created_at)
    self.target_reached_at = nil
    self.returning         = true
    
    # change event!
    self.save
  end
  
  def resources
    @resources = {}

    GameRules::Rules.the_rules().resource_types.each do |resource_type|
      field_name = resource_type[:symbolic_id].to_s() + '_amount'
      @resources[resource_type[:id]] = self[field_name]    unless self[field_name].blank? 
    end    

    @resources     
  end
  
  def total_resources
    total = 0
    GameRules::Rules.the_rules().resource_types.each do |resource_type|
      total += self[resource_type[:symbolic_id].to_s() + '_amount'] || 0
    end     
    total
  end
  
  def load_resources
    self.starting_settlement.owner.resource_pool.remove_resources_transaction(self.resources)
  end
  
  def unload_resources_at_target
    self.target_settlement.owner.resource_pool.add_resources_transaction(self.resources)
  end
  
  def unload_resources_at_origin
    self.starting_settlement.owner.resource_pool.add_resources_transaction(self.resources)
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
