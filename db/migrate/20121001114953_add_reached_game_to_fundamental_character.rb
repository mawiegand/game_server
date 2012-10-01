class AddReachedGameToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :reached_game, :datetime
  end
end
