class AddAllianceColorToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :alliance_color, :integer
  end
end
