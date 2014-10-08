class CreateShopGoogleMoneyTransactions < ActiveRecord::Migration
  def change
    create_table :shop_google_money_transactions do |t|
      t.string :identifier
      t.string :google_product_id
      t.string :google_payment_token
      t.integer :credits
      t.integer :test

      t.timestamps
    end
  end
end
