class ChangeDefaultValuesOfRankingAllianceRanking < ActiveRecord::Migration
  def up
    change_column :ranking_alliance_rankings, :overall_score, :integer,    { :default => 0, :null => false}
    change_column :ranking_alliance_rankings, :resource_score, :integer,  { :default => 0, :null => false}
    change_column :ranking_alliance_rankings, :power_score, :integer,     { :default => 0, :null => false}
    change_column :ranking_alliance_rankings, :num_settlements, :integer, { :default => 0, :null => false}
    change_column :ranking_alliance_rankings, :num_outposts, :integer,    { :default => 0, :null => false}
    change_column :ranking_alliance_rankings, :num_fortress, :integer,    { :default => 0, :null => false}
    change_column :ranking_alliance_rankings, :num_members, :integer,    { :default => 0, :null => false}

  end

  def down
    change_column :ranking_alliance_rankings, :overall_score, :integer,    { :null => true}
    change_column :ranking_alliance_rankings, :resource_score, :integer,  { :null => true}
    change_column :ranking_alliance_rankings, :power_score, :integer,     { :null => true}
    change_column :ranking_alliance_rankings, :num_settlements, :integer, { :null => true}
    change_column :ranking_alliance_rankings, :num_outposts, :integer,    { :null => true}
    change_column :ranking_alliance_rankings, :num_fortress, :integer,    { :null => true}
    change_column :ranking_alliance_rankings, :num_members, :integer,    { :null => true}

  end    
end
