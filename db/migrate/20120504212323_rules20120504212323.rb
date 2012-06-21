class Rules20120504212323 < ActiveRecord::Migration
  def change
    add_column :military_army_details,   :unit_tree_huggers,   :integer
    add_column :military_army_details,   :unit_sabre_riders,   :integer
    add_column :military_army_details,   :unit_squirrel_hunters,   :integer
    add_column :military_battle_participant_results,   :unit_tree_huggers,   :integer
    add_column :military_battle_participant_results,   :unit_tree_huggers_casualties,   :integer
    add_column :military_battle_participant_results,   :unit_tree_huggers_damage_taken,   :decimal
    add_column :military_battle_participant_results,   :unit_tree_huggers_damage_inflicted,   :decimal
    add_column :military_battle_participant_results,   :unit_sabre_riders,   :integer
    add_column :military_battle_participant_results,   :unit_sabre_riders_casualties,   :integer
    add_column :military_battle_participant_results,   :unit_sabre_riders_damage_taken,   :decimal
    add_column :military_battle_participant_results,   :unit_sabre_riders_damage_inflicted,   :decimal
    add_column :military_battle_participant_results,   :unit_squirrel_hunters,   :integer
    add_column :military_battle_participant_results,   :unit_squirrel_hunters_casualties,   :integer
    add_column :military_battle_participant_results,   :unit_squirrel_hunters_damage_taken,   :decimal
    add_column :military_battle_participant_results,   :unit_squirrel_hunters_damage_inflicted,   :decimal
  end
end
