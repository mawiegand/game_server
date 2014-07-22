class AddRandomToCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :random, :integer
  end
end
