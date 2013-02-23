class AddLastDeletedAtToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :last_deleted_at, :datetime
  end
end
