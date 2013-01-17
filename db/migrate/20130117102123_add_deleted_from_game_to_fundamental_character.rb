class AddDeletedFromGameToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :deleted_from_game, :boolean, :default => false, :empty => false
  end
end
