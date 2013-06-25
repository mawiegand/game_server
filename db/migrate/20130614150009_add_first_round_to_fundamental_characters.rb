class AddFirstRoundToFundamentalCharacters < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :first_round, :boolean
  end
end
