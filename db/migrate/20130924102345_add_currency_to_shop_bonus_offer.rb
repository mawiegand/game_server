class AddCurrencyToShopBonusOffer < ActiveRecord::Migration
  def change
    add_column :shop_bonus_offers, :currency, :integer
  end
end
