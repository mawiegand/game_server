class AddPremiumExpirationToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :premium_expiration, :datetime
  end
end
