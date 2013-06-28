class AddAssignmentLevelToSettlementSettlement < ActiveRecord::Migration
  def change
    add_column :settlement_settlements, :assignment_level, :integer, :default => 0, :null => false
  end
end
