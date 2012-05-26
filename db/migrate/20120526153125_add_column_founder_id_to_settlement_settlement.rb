class AddColumnFounderIdToSettlementSettlement < ActiveRecord::Migration
  def change
    add_column :settlement_settlements, :founder_id, :integer
  end
end
