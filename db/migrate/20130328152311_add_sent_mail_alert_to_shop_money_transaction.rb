class AddSentMailAlertToShopMoneyTransaction < ActiveRecord::Migration
  def change
    add_column :shop_money_transactions, :sent_mail_alert, :boolean, :default => false
  end
end
