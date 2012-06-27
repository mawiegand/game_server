class AddScoreToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :score, :integer
  end
end
