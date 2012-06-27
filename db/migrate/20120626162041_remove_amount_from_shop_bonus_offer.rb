class RemoveAmountFromShopBonusOffer < ActiveRecord::Migration
  def up
    remove_column :shop_bonus_offers, :amount
  end

  def down
    add_column :shop_bonus_offers, :amount, :integer
  end
end
