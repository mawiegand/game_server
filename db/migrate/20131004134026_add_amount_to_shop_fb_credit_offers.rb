class AddAmountToShopFbCreditOffers < ActiveRecord::Migration
  def change
    add_column :shop_fb_credit_offers, :amount, :integer
  end
end
