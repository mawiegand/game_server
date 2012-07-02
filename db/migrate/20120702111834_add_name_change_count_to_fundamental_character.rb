class AddNameChangeCountToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :name_change_count, :integer, {:default => 0, :null => false}
    add_column :fundamental_characters, :login_count, :integer, {:default => 0, :null => false}
  end
end
