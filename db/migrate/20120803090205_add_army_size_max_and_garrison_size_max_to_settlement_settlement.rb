class AddArmySizeMaxAndGarrisonSizeMaxToSettlementSettlement < ActiveRecord::Migration
  def change
    add_column :settlement_settlements, :army_size_max, :integer
    add_column :settlement_settlements, :garrison_size_max, :integer
  end
end
