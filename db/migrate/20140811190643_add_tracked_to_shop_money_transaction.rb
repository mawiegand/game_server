class AddTrackedToShopMoneyTransaction < ActiveRecord::Migration
  def change
    add_column :shop_money_transactions, :tracked,            :boolean, :default => false, :null => false
    add_column :shop_money_transactions, :chargeback_tracked, :boolean, :default => false, :null => false
  end
end
