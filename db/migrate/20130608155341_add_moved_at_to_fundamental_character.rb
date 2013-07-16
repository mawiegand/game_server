class AddMovedAtToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :moved_at, :datetime
  end
end
