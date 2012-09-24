class AddGenderToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :gender, :string
    add_column :fundamental_characters, :gender_change_count, :integer, :default => 0,      :null => false
  end
end
