class AddNpcToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :npc, :boolean, { :default => false, :null => false }
  end
end
