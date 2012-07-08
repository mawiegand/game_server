class AddLastLoginAtToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :last_login_at, :datetime
  end
end
