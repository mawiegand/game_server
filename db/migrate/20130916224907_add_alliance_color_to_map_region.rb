class AddAllianceColorToMapRegion < ActiveRecord::Migration
  def change
    add_column :map_regions, :alliance_color, :integer
  end
end
