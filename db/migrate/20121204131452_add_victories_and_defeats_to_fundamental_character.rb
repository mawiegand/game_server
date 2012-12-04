class AddVictoriesAndDefeatsToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :victories, :integer, :default => 0, :null => false
    add_column :fundamental_characters, :defeats, :integer, :default => 0, :null => false
  end
end
