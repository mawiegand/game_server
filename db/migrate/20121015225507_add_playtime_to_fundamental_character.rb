class AddPlaytimeToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :playtime, :decimal, :default => 0.0, :null => false
  end
end
