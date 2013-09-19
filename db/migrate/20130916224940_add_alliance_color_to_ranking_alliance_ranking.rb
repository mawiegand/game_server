class AddAllianceColorToRankingAllianceRanking < ActiveRecord::Migration
  def change
    add_column :ranking_alliance_rankings, :alliance_color, :integer
  end
end
