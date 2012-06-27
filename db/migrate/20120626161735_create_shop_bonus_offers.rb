class CreateShopBonusOffers < ActiveRecord::Migration
  def change
    create_table :shop_bonus_offers do |t|
      t.string :title
      t.integer :price
      t.integer :amount
      t.integer :resource_id
      t.integer :speedup
      t.datetime :started_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
