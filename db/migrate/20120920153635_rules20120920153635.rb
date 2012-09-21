class Rules20120920153635 < ActiveRecord::Migration
  def change
    add_column :military_armies,   :unitcategory_special_strength,   :decimal,  {}    
    add_column :military_army_details,   :unit_little_chief,   :integer,  {}    
    add_column :military_battle_factions,   :unitcategory_special_strength,   :decimal,  {}    
    add_column :military_battle_participant_results,   :unit_little_chief,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_little_chief_casualties,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_little_chief_damage_taken,   :decimal,  {}    
    add_column :military_battle_participant_results,   :unit_little_chief_damage_inflicted,   :decimal,  {}    
    add_column :settlement_settlements,   :settlement_queue_special_unlock_count,   :integer,  {:default=>0}    
  end
end
