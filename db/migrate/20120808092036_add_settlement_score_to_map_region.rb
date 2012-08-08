class AddSettlementScoreToMapRegion < ActiveRecord::Migration
  def change
    add_column :map_regions, :settlement_score, :integer, :default => 0, :null => false
  end
end
