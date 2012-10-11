class CreateShopPlatinumOffers < ActiveRecord::Migration
  def change
    create_table :shop_platinum_offers do |t|
      t.string :title
      t.integer :price
      t.integer :duration
      t.datetime :started_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
