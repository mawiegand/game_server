class Rules20120826202813 < ActiveRecord::Migration
  def change
    add_column :settlement_settlements,   :settlement_unlock_p2p_trade,   :integer,  {:default=>0}    
  end
end
