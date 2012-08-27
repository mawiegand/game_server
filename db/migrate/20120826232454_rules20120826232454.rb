class Rules20120826232454 < ActiveRecord::Migration
  def change
    add_column :settlement_settlements,   :settlement_unlock_p2p_trade_count,   :integer,  {:default=>0}    
    remove_column :settlement_settlements,   :settlement_unlock_p2p_trade    
  end
end
