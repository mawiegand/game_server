class AddFortressLevelToMapRegion < ActiveRecord::Migration
  def change
    add_column :map_regions, :fortress_level, :integer
  end
end
