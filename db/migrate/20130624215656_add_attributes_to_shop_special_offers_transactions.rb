class AddAttributesToShopSpecialOffersTransactions < ActiveRecord::Migration
  def change
    add_column :shop_special_offers_transactions, :character_id, :integer
    add_column :shop_special_offers_transactions, :state, :integer
  end
end
