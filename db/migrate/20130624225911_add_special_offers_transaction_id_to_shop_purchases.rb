class AddSpecialOffersTransactionIdToShopPurchases < ActiveRecord::Migration
  def change
    add_column :shop_purchases, :special_offers_transaction_id, :integer
  end
end
