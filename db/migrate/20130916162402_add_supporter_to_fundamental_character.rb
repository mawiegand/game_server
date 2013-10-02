class AddSupporterToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :supporter, :boolean, :default => false
  end
end
