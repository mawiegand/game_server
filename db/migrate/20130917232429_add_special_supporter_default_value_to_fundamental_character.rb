class AddSpecialSupporterDefaultValueToFundamentalCharacter < ActiveRecord::Migration
  def change
    change_column :fundamental_characters, :special_supporter, :boolean, :default => false
  end
end
