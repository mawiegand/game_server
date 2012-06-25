class Rules20120625132421 < ActiveRecord::Migration
  def change
    add_column :settlement_settlements,   :settlement_unlock_garrison_count,   :integer,  {:default=>0}    
    add_column :fundamental_characters,   :character_unlock_diplomacy_count,   :integer,  {:default=>0}    
    add_column :fundamental_characters,   :character_unlock_alliance_creation_count,   :integer,  {:default=>0}    
  end
end
