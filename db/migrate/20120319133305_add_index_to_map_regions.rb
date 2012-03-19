class AddIndexToMapRegions < ActiveRecord::Migration
  def change
    add_index :map_regions, :node_id
  end
end
