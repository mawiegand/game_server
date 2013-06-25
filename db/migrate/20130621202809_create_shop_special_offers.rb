class CreateShopSpecialOffers < ActiveRecord::Migration
  def change
    create_table :shop_special_offers do |t|
      t.datetime :startet_at
      t.datetime :ends_at
      t.string :title

      t.timestamps
    end
  end
end
