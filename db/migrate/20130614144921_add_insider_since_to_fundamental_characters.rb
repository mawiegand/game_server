class AddInsiderSinceToFundamentalCharacters < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :insider_since, :datetime
  end
end
