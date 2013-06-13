class RenameMovementPasswordColumnFromMapRegion < ActiveRecord::Migration
  def change
    rename_column :map_regions, :movement_password, :moving_password
  end
end
