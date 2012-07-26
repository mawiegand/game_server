class Rules20120726151738 < ActiveRecord::Migration
  def change
    add_column :military_army_details,   :unit_babysaurus,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_babysaurus,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_babysaurus_casualties,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_babysaurus_damage_taken,   :decimal,  {}    
    add_column :military_battle_participant_results,   :unit_babysaurus_damage_inflicted,   :decimal,  {}    
  end
end
