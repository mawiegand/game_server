class AddLastTakeoverAtToSettlementSettlement < ActiveRecord::Migration
  def change
    add_column :settlement_settlements, :last_takeover_at, :datetime
  end
end
