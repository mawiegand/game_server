class AddMovementPasswordToMapRegion < ActiveRecord::Migration
  def up
    add_column :map_regions, :movement_password, :string
  end

  def down
    remove_column :map_regions, :movement_password
  end
end
