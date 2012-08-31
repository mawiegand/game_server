class AddTradingCartsUsedToSettlementSettlement < ActiveRecord::Migration
  def change
    add_column :settlement_settlements, :trading_carts_used, :integer, :default => 0, :null => false
  end
end
