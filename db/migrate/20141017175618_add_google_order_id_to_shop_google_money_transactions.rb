class AddGoogleOrderIdToShopGoogleMoneyTransactions < ActiveRecord::Migration
  def change
    add_column :shop_google_money_transactions, :google_order_id, :string
  end
end
