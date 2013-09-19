class AddSpecialSupporterToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :special_supporter, :boolean
  end
end
