class CreateMilitaryBattles < ActiveRecord::Migration
  def change
    create_table :military_battles do |t|
      t.datetime :started_at
      t.datetime :ended_at
      t.datetime :next_round_at
      t.integer :initiator_id
      t.integer :opponent_id
      t.integer :location_id
      t.integer :region_id
      t.integer :importance_rating
      t.integer :decisiveness
      t.integer :factions_count
      t.integer :rounds_count

      t.timestamps
    end
  end
end
