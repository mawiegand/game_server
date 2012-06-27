class CreateShopResourceOffers < ActiveRecord::Migration
  def change
    create_table :shop_resource_offers do |t|
      t.string :title
      t.integer :price
      t.integer :amount
      t.integer :resource_id
      t.datetime :started_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
