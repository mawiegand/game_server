class AddSettlementTypeIdToMapRegion < ActiveRecord::Migration
  def change
    add_column    :map_regions,   :settlement_type_id, :integer
    rename_column :map_regions,   :fortress_level,     :settlement_level
    rename_column :map_locations, :level,              :settlement_level
    rename_column :map_locations, :type_id,            :settlement_type_id
  end
end
