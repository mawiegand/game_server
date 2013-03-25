class Rules20130325183017 < ActiveRecord::Migration
  def change
    add_column :military_army_details,   :unit_warrior,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_warrior,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_warrior_casualties,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_warrior_damage_taken,   :decimal,  {}    
    add_column :military_battle_participant_results,   :unit_warrior_damage_inflicted,   :decimal,  {}    
  end
end
