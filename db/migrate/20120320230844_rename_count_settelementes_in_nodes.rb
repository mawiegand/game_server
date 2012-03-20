class RenameCountSettelementesInNodes < ActiveRecord::Migration
  def change
    rename_column :map_nodes, :count_settlementes, :count_settlements
  end
end
