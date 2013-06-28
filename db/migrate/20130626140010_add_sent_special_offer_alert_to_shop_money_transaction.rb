class AddSentSpecialOfferAlertToShopMoneyTransaction < ActiveRecord::Migration
  def change
    add_column :shop_money_transactions, :sent_special_offer_alert, :boolean
  end
end
