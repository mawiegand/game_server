class CreateShopOffers < ActiveRecord::Migration
  def change
    create_table :shop_offers do |t|
      t.string :title
      t.string :description
      t.integer :price
      t.integer :amount

      t.timestamps
    end
  end
end
