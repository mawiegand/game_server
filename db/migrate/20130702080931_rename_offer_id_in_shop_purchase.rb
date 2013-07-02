class RenameOfferIdInShopPurchase < ActiveRecord::Migration
  def change
    rename_column :shop_purchases, :offer_id, :external_offer_id
  end
end
