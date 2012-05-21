class CreateShopTransactions < ActiveRecord::Migration
  def change
    create_table :shop_transactions do |t|
      t.integer :character_id
      t.integer :credit_amount_booked
      t.integer :credit_amount_before
      t.integer :credit_amount_after
      t.string :offer
      t.integer :state

      t.timestamps
    end
  end
end
