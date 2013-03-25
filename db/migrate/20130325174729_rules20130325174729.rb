class Rules20130325174729 < ActiveRecord::Migration
  def change
    add_column :military_army_details,   :unit_warriror,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_warriror,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_warriror_casualties,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_warriror_damage_taken,   :decimal,  {}    
    add_column :military_battle_participant_results,   :unit_warriror_damage_inflicted,   :decimal,  {}    
  end
end
