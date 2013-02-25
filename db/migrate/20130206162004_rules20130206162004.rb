class Rules20130206162004 < ActiveRecord::Migration
  def change
    add_column :backend_trade_log_entries,   :resource_stone_amount,   :integer,  {:default=>0, :null=>false}    
    add_column :backend_trade_log_entries,   :resource_wood_amount,   :integer,  {:default=>0, :null=>false}    
    add_column :backend_trade_log_entries,   :resource_fur_amount,   :integer,  {:default=>0, :null=>false}    
    add_column :backend_trade_log_entries,   :resource_cash_amount,   :integer,  {:default=>0, :null=>false}    
  end
end
