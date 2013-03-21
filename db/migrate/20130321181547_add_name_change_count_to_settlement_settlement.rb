class AddNameChangeCountToSettlementSettlement < ActiveRecord::Migration
  def change
    add_column :settlement_settlements, :name_change_count, :integer, :default => 0
  end
end
