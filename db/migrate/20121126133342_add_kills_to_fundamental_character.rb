class AddKillsToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters,     :kills,      :integer, :default => 0, :null => false
    add_column :ranking_character_rankings, :kills,      :integer, :default => 0, :null => false
    add_column :ranking_character_rankings, :kills_rank, :integer
    add_column :ranking_alliance_rankings,  :kills,      :integer, :default => 0, :null => false
    add_column :ranking_allinace_rankings,  :kills_rank, :integer

  end
end
