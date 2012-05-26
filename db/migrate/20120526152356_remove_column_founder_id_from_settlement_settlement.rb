class RemoveColumnFounderIdFromSettlementSettlement < ActiveRecord::Migration
  def change
    remove_column :settlement_settlements, :founder_id
  end
end
