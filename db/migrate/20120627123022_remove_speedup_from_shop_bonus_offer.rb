class RemoveSpeedupFromShopBonusOffer < ActiveRecord::Migration
  def up
    remove_column :shop_bonus_offers, :speedup
  end

  def down
    add_column :shop_bonus_offers, :speedup, :decimal
  end
end
