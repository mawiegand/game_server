class AddTrackedToShopFbMoneyTransaction < ActiveRecord::Migration
  def change
    add_column :shop_fb_money_transactions,     :tracked, :boolean, :default => false, :null => false
    add_column :shop_google_money_transactions, :tracked, :boolean, :default => false, :null => false
  end
end
