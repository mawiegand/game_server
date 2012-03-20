class AddIndexToMapLocations < ActiveRecord::Migration
  def change
    add_index :map_locations, :region_id
    add_index :map_locations, :type_id
  end
end
