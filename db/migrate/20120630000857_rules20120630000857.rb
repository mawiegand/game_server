class Rules20120630000857 < ActiveRecord::Migration
  def change
    add_column :settlement_settlements,   :settlement_queue_artillery_unlock_count,   :integer,  {:default=>0}    
    add_column :settlement_settlements,   :settlement_queue_cavalry_unlock_count,   :integer,  {:default=>0}    
    add_column :settlement_settlements,   :settlement_queue_siege_unlock_count,   :integer,  {:default=>0}    
  end
end
