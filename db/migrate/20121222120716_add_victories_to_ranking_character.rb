class AddVictoriesToRankingCharacter < ActiveRecord::Migration
  def up
    add_column :ranking_character_rankings,  :victories, :integer,  :default => 0, :null => false
    add_column :ranking_character_rankings,  :defeats, :integer,    :default => 0, :null => false
    add_column :ranking_character_rankings,  :victory_ratio, :decimal,  :default => 0, :null => false
    add_column :ranking_character_rankings,  :likes, :integer,      :default => 0, :null => false
    add_column :ranking_character_rankings,  :dislikes, :integer,   :default => 0, :null => false
    add_column :ranking_character_rankings,  :like_ratio, :decimal, :default => 0, :null => false
    
    Fundamental::Character.non_npc.each do |character|
      character.ranking.victories = character.victories
      character.ranking.defeats   = character.defeats
      character.ranking.likes     = character.received_likes_count
      character.ranking.dislikes  = character.received_dislikes_count
      character.ranking.save
    end
  end

  def down
    remove_column :ranking_character_rankings,  :victories
    remove_column :ranking_character_rankings,  :defeats
    remove_column :ranking_character_rankings,  :victory_ratio
    remove_column :ranking_character_rankings,  :likes
    remove_column :ranking_character_rankings,  :dislikes
    remove_column :ranking_character_rankings,  :like_ratio
  end
end
