class ChangeUidOfShopMonetTransaction < ActiveRecord::Migration
  def change
    add_index :shop_money_transactions, :uid, :unique => true
  end
end
