class CreateRankingAllianceRankings < ActiveRecord::Migration
  def change
    create_table :ranking_alliance_rankings do |t|
      t.integer :alliance_id
      t.string :alliance_tag
      t.integer :overall_score
      t.integer :overall_rank
      t.integer :resource_score
      t.integer :resource_rank
      t.integer :power_score
      t.integer :power_rank
      t.integer :num_settlements
      t.integer :settlements_rank
      t.integer :num_outposts
      t.integer :outposts_rank
      t.integer :num_fortress
      t.integer :fortress_rank
      t.integer :num_members
      t.integer :members_rank

      t.timestamps
    end
  end
end
