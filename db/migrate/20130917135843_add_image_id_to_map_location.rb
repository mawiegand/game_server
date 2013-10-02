class AddImageIdToMapLocation < ActiveRecord::Migration
  def change
    add_column :map_locations, :image_id, :integer
  end
end
