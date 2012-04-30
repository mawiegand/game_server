class CreateMilitaryBattleParticipants < ActiveRecord::Migration
  def change
    create_table :military_battle_participants do |t|
      t.integer :army_id
      t.integer :battle_id
      t.integer :faction_id
      t.datetime :joined_at
      t.boolean :retreat
      t.integer :retreat_to_region_id
      t.integer :retreat_to_location_id

      t.timestamps
    end
  end
end
