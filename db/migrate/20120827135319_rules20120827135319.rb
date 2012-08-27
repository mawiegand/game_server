class Rules20120827135319 < ActiveRecord::Migration
  def change
    add_column :action_trading_trading_carts_actions,   :resource_stone_amount,   :integer,  {}    
    add_column :action_trading_trading_carts_actions,   :resource_wood_amount,   :integer,  {}    
    add_column :action_trading_trading_carts_actions,   :resource_fur_amount,   :integer,  {}    
    add_column :action_trading_trading_carts_actions,   :resource_cash_amount,   :integer,  {}    
  end
end
