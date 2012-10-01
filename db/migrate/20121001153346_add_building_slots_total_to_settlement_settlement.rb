class AddBuildingSlotsTotalToSettlementSettlement < ActiveRecord::Migration
  def change
    add_column :settlement_settlements, :building_slots_total, :integer,    default: 1, null: false
  end
end
