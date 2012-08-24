class AddLastRequestAtToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :last_request_at, :datetime
  end
end
