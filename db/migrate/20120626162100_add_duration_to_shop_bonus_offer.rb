class AddDurationToShopBonusOffer < ActiveRecord::Migration
  def change
    add_column :shop_bonus_offers, :duration, :integer
  end
end
