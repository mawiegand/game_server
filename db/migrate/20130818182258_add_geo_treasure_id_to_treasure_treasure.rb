class AddGeoTreasureIdToTreasureTreasure < ActiveRecord::Migration
  def change
    add_column :treasure_treasures, :geo_treasure_id, :integer
  end
end
