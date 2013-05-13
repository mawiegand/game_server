class AddAllianceSizeBonusToFundamentalCharacters < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :alliance_size_bonus, :integer, :default => 0
  end
end
