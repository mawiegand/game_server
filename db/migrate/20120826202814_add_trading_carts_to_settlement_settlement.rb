class AddTradingCartsToSettlementSettlement < ActiveRecord::Migration
  def change
    add_column :settlement_settlements, :trading_carts, :integer, :default => 0, :null => false
  end
end
