class AddColumnArmiesChangedAtToMapRegion < ActiveRecord::Migration
  def change
    add_column :map_regions, :armies_changed_at, :datetime
    add_column :map_locations, :armies_changed_at, :datetime
  end
end
