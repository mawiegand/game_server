class AddSettlementScoreToMapLocation < ActiveRecord::Migration
  def change
    add_column :map_locations, :settlement_score, :integer, :default => 0, :null => false
  end
end
