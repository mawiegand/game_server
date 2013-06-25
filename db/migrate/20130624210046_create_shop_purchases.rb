class CreateShopPurchases < ActiveRecord::Migration
  def change
    create_table :shop_purchases do |t|
      t.string :offer_type
      t.integer :offer_id
      t.datetime :redeemed_at

      t.timestamps
    end
  end
end
