class CreateMilitaryBattleFactions < ActiveRecord::Migration
  def change
    create_table :military_battle_factions do |t|
      t.integer :battle_id
      t.integer :faction_num
      t.integer :leader_id
      t.datetime :joined_at
      t.string :present_command
      t.integer :total_casualties
      t.integer :total_kills
      t.decimal :total_damage_inflicted
      t.decimal :total_damage_taken
      t.integer :total_hitpoints

      t.timestamps
    end
  end
end
