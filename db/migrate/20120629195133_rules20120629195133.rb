class Rules20120629195133 < ActiveRecord::Migration
  def change
    add_column :settlement_settlements,   :settlement_unlock_diplomacy_count,   :integer,  {:default=>0}    
    add_column :settlement_settlements,   :settlement_unlock_alliance_creation_count,   :integer,  {:default=>0}    
  end
end
