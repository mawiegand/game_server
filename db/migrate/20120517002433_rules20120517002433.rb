class Rules20120517002433 < ActiveRecord::Migration
  def change
    add_column :military_armies,   :unitcategory_siege_strength,   :decimal
    add_column :military_army_details,   :unit_tree_huggers,   :integer
    add_column :military_army_details,   :unit_sabre_riders,   :integer
    add_column :military_army_details,   :unit_squirrel_hunters,   :integer
    add_column :military_army_details,   :unit_clubbers,   :integer
    add_column :military_army_details,   :unit_catapult,   :integer
    add_column :military_army_details,   :unit_ram,   :integer
    add_column :military_battle_factions,   :unitcategory_siege_strength,   :decimal
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
    add_column :military_battle_participant_results,   :unit_clubbers,   :integer
    add_column :military_battle_participant_results,   :unit_clubbers_casualties,   :integer
    add_column :military_battle_participant_results,   :unit_clubbers_damage_taken,   :decimal
    add_column :military_battle_participant_results,   :unit_clubbers_damage_inflicted,   :decimal
    add_column :military_battle_participant_results,   :unit_catapult,   :integer
    add_column :military_battle_participant_results,   :unit_catapult_casualties,   :integer
    add_column :military_battle_participant_results,   :unit_catapult_damage_taken,   :decimal
    add_column :military_battle_participant_results,   :unit_catapult_damage_inflicted,   :decimal
    add_column :military_battle_participant_results,   :unit_ram,   :integer
    add_column :military_battle_participant_results,   :unit_ram_casualties,   :integer
    add_column :military_battle_participant_results,   :unit_ram_damage_taken,   :decimal
    add_column :military_battle_participant_results,   :unit_ram_damage_inflicted,   :decimal
  end
end
