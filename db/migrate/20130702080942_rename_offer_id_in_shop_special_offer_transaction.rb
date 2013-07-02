class RenameOfferIdInShopSpecialOfferTransaction < ActiveRecord::Migration
  def change
    rename_column :shop_special_offers_transactions, :offer_id, :external_offer_id
  end
end
