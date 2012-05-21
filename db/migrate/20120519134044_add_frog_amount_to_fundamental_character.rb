class AddFrogAmountToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :frog_amount, :integer, :default => 0
  end
end
