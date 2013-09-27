class AddWearToSettlementSettlement < ActiveRecord::Migration
  def change
    add_column :settlement_settlements, :battle_id,            :integer
    add_column :settlement_settlements, :condition,            :decimal, :default => 1.0, :null => false
    add_column :settlement_settlements, :condition_updated_at, :datetime
  end
end
