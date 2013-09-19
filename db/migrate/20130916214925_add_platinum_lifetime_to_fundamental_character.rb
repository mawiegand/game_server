class AddPlatinumLifetimeToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :platinum_lifetime, :boolean, :default => false
  end
end
