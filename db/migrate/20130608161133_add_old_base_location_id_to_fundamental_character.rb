class AddOldBaseLocationIdToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :old_base_location_id, :integer
  end
end
