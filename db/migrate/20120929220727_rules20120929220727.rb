class Rules20120929220727 < ActiveRecord::Migration
  def change
    add_column :settlement_settlements,   :settlement_unlock_prevent_takeover_count,   :integer,  {:default=>0, :null => false}    
  end
end
