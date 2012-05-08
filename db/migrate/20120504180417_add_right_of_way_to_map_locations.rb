class AddRightOfWayToMapLocations < ActiveRecord::Migration
  def change
    add_column :map_locations, :right_of_way, :integer
  end
end
