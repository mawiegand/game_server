class Rules20131026165154 < ActiveRecord::Migration
  def change
    add_column :military_army_details,   :unit_great_chief,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_great_chief,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_great_chief_casualties,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_great_chief_damage_taken,   :decimal,  {}    
    add_column :military_battle_participant_results,   :unit_great_chief_damage_inflicted,   :decimal,  {}    
    add_column :assignment_special_assignments,   :unit_great_chief_deposit,   :integer,  {}    
    add_column :assignment_special_assignments,   :unit_great_chief_reward,   :integer,  {}    
  end
end
