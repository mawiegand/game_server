class Rules20120715135916 < ActiveRecord::Migration
  def change
    add_column :military_army_details,   :unit_neanderthal,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_neanderthal,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_neanderthal_casualties,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_neanderthal_damage_taken,   :decimal,  {}    
    add_column :military_battle_participant_results,   :unit_neanderthal_damage_inflicted,   :decimal,  {}    
  end
end
