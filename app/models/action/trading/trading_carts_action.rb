class Action::Trading::TradingCartsAction < ActiveRecord::Base
  
  belongs_to :starting_settlement, :class_name => "Settlement::Settlement", :foreign_key => "starting_settlement_id", :inverse_of => :outgoing_trading_carts
  belongs_to :target_settlement,   :class_name => "Settlement::Settlement", :foreign_key => "target_settlement_id",   :inverse_of => :incoming_trading_carts  
  
end
