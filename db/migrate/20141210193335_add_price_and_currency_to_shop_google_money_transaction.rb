class AddPriceAndCurrencyToShopGoogleMoneyTransaction < ActiveRecord::Migration
  def change
    add_column :shop_google_money_transactions, :price, :decimal
    add_column :shop_google_money_transactions, :currency, :string
  end
end
