class AddGrossToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :gross, :decimal, :default => 0.0, :null => :false
  end
end
