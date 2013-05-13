class AddAllianceSizeBonusToSettlementSettlements < ActiveRecord::Migration
  def change
    add_column :settlement_settlements, :alliance_size_bonus, :integer, :default => 0
  end
end
