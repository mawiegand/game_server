class CreateShopSpecialOffersTransactions < ActiveRecord::Migration
  def change
    create_table :shop_special_offers_transactions do |t|
      t.integer :offer_id

      t.timestamps
    end
  end
end
