class AddTaxChangedAtToSettlementSettlement < ActiveRecord::Migration
  def change
    add_column :settlement_settlements, :tax_changed_at, :datetime
  end
end
