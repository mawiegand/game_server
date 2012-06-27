class AddScoreToSettlementSettlement < ActiveRecord::Migration
  def change
    add_column :settlement_settlements, :score, :integer
  end
end
