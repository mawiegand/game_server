class Rules < ActiveRecord::Migration
  def change
    add_column :military_battle_participant_results,   :unit_thrower,   :integer
    add_column :military_battle_participant_results,   :unit_thrower_casualties,   :integer
    add_column :military_battle_participant_results,   :unit_thrower_damage_taken,   :decimal
    add_column :military_battle_participant_results,   :unit_thrower_damage_inflicted,   :decimal
    add_column :military_battle_participant_results,   :unit_skewer,   :integer
    add_column :military_battle_participant_results,   :unit_skewer_casualties,   :integer
    add_column :military_battle_participant_results,   :unit_skewer_damage_taken,   :decimal
    add_column :military_battle_participant_results,   :unit_skewer_damage_inflicted,   :decimal
    add_column :military_battle_participant_results,   :unit_light_cavalry,   :integer
    add_column :military_battle_participant_results,   :unit_light_cavalry_casualties,   :integer
    add_column :military_battle_participant_results,   :unit_light_cavalry_damage_taken,   :decimal
    add_column :military_battle_participant_results,   :unit_light_cavalry_damage_inflicted,   :decimal
  end
end
