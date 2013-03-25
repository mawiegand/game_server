class RemoveWarrirorFromArmyDetails < ActiveRecord::Migration
  def up
    remove_column :military_army_details,   :unit_warriror    
    remove_column :military_battle_participant_results,   :unit_warriror
    remove_column :military_battle_participant_results,   :unit_warriror_casualties   
    remove_column :military_battle_participant_results,   :unit_warriror_damage_taken
    remove_column :military_battle_participant_results,   :unit_warriror_damage_inflicted   
  end

  def down
    add_column :military_army_details,   :unit_warriror,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_warriror,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_warriror_casualties,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_warriror_damage_taken,   :decimal,  {}    
    add_column :military_battle_participant_results,   :unit_warriror_damage_inflicted,   :decimal,  {}    
  end
end
