class AddColumnBaseNodeIdToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :base_node_id, :integer
  end
end
