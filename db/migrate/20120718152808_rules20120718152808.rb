class Rules20120718152808 < ActiveRecord::Migration
  def change
    add_column :military_army_details,   :unit_slingshot_warrior,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_slingshot_warrior,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_slingshot_warrior_casualties,   :integer,  {}    
    add_column :military_battle_participant_results,   :unit_slingshot_warrior_damage_taken,   :decimal,  {}    
    add_column :military_battle_participant_results,   :unit_slingshot_warrior_damage_inflicted,   :decimal,  {}    
  end
end
