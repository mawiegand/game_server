class CreateShopFbMoneyTransactions < ActiveRecord::Migration
  def change
    create_table :shop_fb_money_transactions do |t|
      t.string :identifier
      t.string :fb_user_id
      t.string :fb_user_name
      t.string :payment_id
      t.integer :fb_offer_id
      t.integer :credits
      t.string :amount
      t.string :currency
      t.string :country
      t.decimal :payout_foreign_exchange_rate
      t.integer :test

      t.timestamps
    end
  end
end
