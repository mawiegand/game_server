class AddExperienceRankingToRankingCharacterRanking < ActiveRecord::Migration
  def change
    add_column :ranking_character_rankings, :max_experience, :integer,        :default => 0, :null => false
    add_column :ranking_character_rankings, :max_experience_rank, :integer
    add_column :ranking_character_rankings, :max_experience_army_name, :string
    add_column :ranking_character_rankings, :max_experience_army_rank, :integer
  end
end
