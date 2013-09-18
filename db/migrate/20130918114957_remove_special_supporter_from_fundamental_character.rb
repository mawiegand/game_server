class RemoveSpecialSupporterFromFundamentalCharacter < ActiveRecord::Migration
  def change
    remove_column :fundamental_characters, :special_supporter
  end
end
