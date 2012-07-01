class RemoveFrogAmountFromFundamentalCharacter < ActiveRecord::Migration
  def up
    remove_column :fundamental_characters, :frog_amount
  end

  def down
    add_column :fundamental_characters, :frog_amount, :integer
  end
end
