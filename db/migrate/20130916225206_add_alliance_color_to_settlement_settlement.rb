class AddAllianceColorToSettlementSettlement < ActiveRecord::Migration
  def change
    add_column :settlement_settlements, :alliance_color, :integer
  end
end
