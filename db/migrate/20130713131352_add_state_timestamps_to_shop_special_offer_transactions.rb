class AddStateTimestampsToShopSpecialOfferTransactions < ActiveRecord::Migration
  def change
    add_column :shop_special_offers_transactions, :paid_at, :datetime
    add_column :shop_special_offers_transactions, :redeemed_at, :datetime
  end
end
