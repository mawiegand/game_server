class AddDescriptionToFundamentalCharacters < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :description, :text
  end
end
