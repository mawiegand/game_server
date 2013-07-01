class AddPremiumExpirationDisplayedAtToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :premium_expiration_displayed_at, :datetime
  end
end
