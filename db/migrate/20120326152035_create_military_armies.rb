class CreateMilitaryArmies < ActiveRecord::Migration
  def change
    create_table :military_armies do |t|
      t.string :name
      t.integer :home_settlement_id
      t.string :home_settlement_name
      t.integer :location_id
      t.integer :owner_id
      t.string :owner_name
      t.integer :alliance_id
      t.string :alliance_tag
      t.integer :ap_max
      t.integer :ap_present
      t.integer :ap_seconds_per_point
      t.datetime :ap_last
      t.integer :mode
      t.integer :stance
      t.integer :size_max
      t.integer :size_present
      t.integer :strength
      t.integer :exp
      t.integer :rank
      t.integer :target_region_id
      t.integer :target_location_id
      t.datetime :target_reached_at
      t.boolean :battle_retreat
      t.integer :battle_id

      t.timestamps
    end
  end
end
