class AddColumnAllianceTagToSettlementSettlement < ActiveRecord::Migration
  def change
    add_column :settlement_settlements, :alliance_tag, :string
  end
end
