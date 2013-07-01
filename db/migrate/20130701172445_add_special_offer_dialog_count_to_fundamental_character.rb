class AddSpecialOfferDialogCountToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :special_offer_dialog_count, :integer, :default => 0
  end
end
