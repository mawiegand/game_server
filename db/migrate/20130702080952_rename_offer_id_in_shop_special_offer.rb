class RenameOfferIdInShopSpecialOffer < ActiveRecord::Migration
  def change
    rename_column :shop_special_offers, :bytro_offer_id, :external_offer_id
  end
end
