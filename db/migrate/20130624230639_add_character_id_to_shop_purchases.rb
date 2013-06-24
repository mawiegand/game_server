class AddCharacterIdToShopPurchases < ActiveRecord::Migration
  def change
    add_column :shop_purchases, :character_id, :integer
  end
end
