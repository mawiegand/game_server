class AddImageIdToMapRegion < ActiveRecord::Migration
  def change
    add_column :map_regions, :image_id, :integer
  end
end
