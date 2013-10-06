class CreateShopFbCreditOffers < ActiveRecord::Migration
  def change
    create_table :shop_fb_credit_offers do |t|
      t.string :title
      t.string :description
      t.string :url
      t.string :image_url
      t.text :prices

      t.timestamps
    end
  end
end
