class CreateShopGoogleCreditOffers < ActiveRecord::Migration
  def change
    create_table :shop_google_credit_offers do |t|
      t.string :google_product_id
      t.string :title
      t.integer :amount
      t.decimal :price

      t.timestamps
    end
  end
end
