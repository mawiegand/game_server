class AddProcessedAtToShopGoogleMoneyTransactions < ActiveRecord::Migration
  def change
    add_column :shop_google_money_transactions, :processed_at, :datetime
  end
end
