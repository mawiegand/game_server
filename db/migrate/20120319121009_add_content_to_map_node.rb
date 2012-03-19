class AddContentToMapNode < ActiveRecord::Migration
  def change
    add_column :map_nodes, :owner_id, :integer
    add_column :map_nodes, :owner_name, :string
    add_column :map_nodes, :alliance_id, :integer
    add_column :map_nodes, :alliance_tag, :string
    add_column :map_nodes, :name, :string
    add_column :map_nodes, :count_fortresses, :integer
    add_column :map_nodes, :count_settlementes, :integer
    add_column :map_nodes, :count_outposts, :integer
    add_column :map_nodes, :terrain_id, :integer
    add_column :map_nodes, :max_level, :integer
    add_column :map_nodes, :total_army_strength, :integer
  end
end
