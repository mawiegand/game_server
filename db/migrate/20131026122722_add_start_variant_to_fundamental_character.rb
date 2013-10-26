class AddStartVariantToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :start_variant, :integer, :default => 1, :null => false
  end
end
