class RenameAttributeOfFundamentalCharacter < ActiveRecord::Migration
  def change
    rename_column :fundamental_characters, :supporter, :divine_supporter
  end
end
