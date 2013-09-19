class AddImageSetIdToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :image_set_id, :integer
  end
end
