class AddAllianceColorToRankingCharacterRanking < ActiveRecord::Migration
  def change
    add_column :ranking_character_rankings, :alliance_color, :integer
  end
end
