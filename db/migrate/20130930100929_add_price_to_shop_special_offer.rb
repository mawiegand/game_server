class AddPriceToShopSpecialOffer < ActiveRecord::Migration
  def change
    add_column :shop_special_offers, :price, :integer
  end
end
