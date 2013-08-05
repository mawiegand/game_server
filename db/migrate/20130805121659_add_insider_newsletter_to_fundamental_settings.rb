class AddInsiderNewsletterToFundamentalSettings < ActiveRecord::Migration
  def change
    add_column :fundamental_settings, :insider_newsletter,    :boolean, default: true,     null: false
    add_column :fundamental_settings, :experimental,          :boolean, default: true,     null: false
  end
end
