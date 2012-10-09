class CreateShopCreditTransactions < ActiveRecord::Migration
  def change
    create_table :shop_credit_transactions do |t|
      t.integer :uid
      t.integer :tstamp
      t.integer :user_id
      t.string :invoice_id
      t.string :title_id
      t.string :game_id
      t.string :country
      t.integer :offer_id
      t.string :option_id
      t.string :offer_category
      t.decimal :gross
      t.string :gross_currency
      t.string :referrer_id
      t.decimal :chargeback
      t.boolean :tutorial
      t.string :tournament_id
      t.boolean :transaction_payed
      t.string :transaction_state
      t.string :comment
      t.decimal :scale_factor
      t.integer :money_tid
      t.string :hash
      t.string :seed
      t.string :partner_user_id

      t.timestamps
    end
  end
end
