class AddBonusToShopBonusOffer < ActiveRecord::Migration
  def change
    add_column :shop_bonus_offers, :bonus, :decimal, {:default => 0.0, :null => false}
  end
end
