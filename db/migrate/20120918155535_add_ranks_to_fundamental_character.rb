class AddRanksToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :mundane_rank,             :integer, :default => 1, :null => false
    add_column :fundamental_characters, :sacred_rank,              :integer, :default => 1, :null => false
    add_column :fundamental_characters, :settlement_points_total,  :integer, :default => 1, :null => false
    add_column :fundamental_characters, :settlement_points_used,   :integer, :default => 0, :null => false
  end
end
