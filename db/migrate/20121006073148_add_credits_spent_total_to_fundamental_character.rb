class AddCreditsSpentTotalToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :credits_spent_total, :integer, :default => 0, :null=> false
  end
end
