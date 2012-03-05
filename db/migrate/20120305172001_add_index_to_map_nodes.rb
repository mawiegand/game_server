class AddIndexToMapNodes < ActiveRecord::Migration
  def change
    add_index :map_nodes, :path
    add_index :map_nodes, :parent_id
  end
end
