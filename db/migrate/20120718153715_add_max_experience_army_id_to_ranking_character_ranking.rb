class AddMaxExperienceArmyIdToRankingCharacterRanking < ActiveRecord::Migration
  def change
    add_column :ranking_character_rankings, :max_experience_army_id, :integer
  end
end
