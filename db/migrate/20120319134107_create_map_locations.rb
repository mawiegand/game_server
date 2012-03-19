class CreateMapLocations < ActiveRecord::Migration
  def change
    create_table :map_locations do |t|
      t.integer :region_id
      t.integer :slot
      t.integer :type
      t.integer :level
      t.integer :count_markers
      t.integer :count_armies
      t.integer :owner_id
      t.string :owner_name
      t.integer :alliance_id
      t.string :alliance_name
      t.boolean :visible

      t.timestamps
    end
  end
end
