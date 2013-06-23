class RenameMovementPasswordColumnFromMapRegion < ActiveRecord::Migration
  def change
    rename_column :map_regions, :movement_password, :moving_password
    
		Map::Region.all.each do |region|
      region.save
    end
  end
end
