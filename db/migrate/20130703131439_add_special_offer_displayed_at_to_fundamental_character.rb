class AddSpecialOfferDisplayedAtToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :special_offer_displayed_at, :datetime
  end
end
