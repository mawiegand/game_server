class AddBytroOfferIdToShopSpecialOffers < ActiveRecord::Migration
  def change
    add_column :shop_special_offers, :bytro_offer_id, :integer
  end
end
