class RemoveContentFromMapNode < ActiveRecord::Migration
  def up
    remove_column :map_nodes, :owner_id
    remove_column :map_nodes, :owner_name
    remove_column :map_nodes, :alliance_id
    remove_column :map_nodes, :alliance_tag
    remove_column :map_nodes, :name
    remove_column :map_nodes, :count_fortresses
    remove_column :map_nodes, :count_outposts
    remove_column :map_nodes, :terrain_id
    remove_column :map_nodes, :max_level
  end

  def down
    add_column :map_nodes, :owner_id, :integer
    add_column :map_nodes, :owner_name, :string
    add_column :map_nodes, :alliance_id, :integer
    add_column :map_nodes, :alliance_tag, :string
    add_column :map_nodes, :name, :string
    add_column :map_nodes, :count_fortresses, :integer
    add_column :map_nodes, :count_outposts, :integer
    add_column :map_nodes, :terrain_id, :integer
    add_column :map_nodes, :max_level, :integer
  end
end
