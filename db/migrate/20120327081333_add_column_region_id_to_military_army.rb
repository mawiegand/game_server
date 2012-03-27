class AddColumnRegionIdToMilitaryArmy < ActiveRecord::Migration
  def change
    add_column :military_armies, :region_id, :integer
  end
end
