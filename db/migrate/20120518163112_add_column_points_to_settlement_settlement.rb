class AddColumnPointsToSettlementSettlement < ActiveRecord::Migration
  def change
    add_column :settlement_settlements, :points, :integer
  end
end
