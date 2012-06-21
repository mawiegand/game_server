class AddColumnNameToSettlementSettlement < ActiveRecord::Migration
  def change
    add_column :settlement_settlements, :name, :string, { default: 'Settlement', null: false }
  end
end
