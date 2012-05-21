class ChangeRegionLocationIdToBaseRegionIdForFundamentalCharacter < ActiveRecord::Migration
  def change
    rename_column :fundamental_characters, :region_location_id, :base_region_id
  end

end
