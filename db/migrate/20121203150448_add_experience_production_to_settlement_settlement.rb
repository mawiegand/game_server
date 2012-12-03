class AddExperienceProductionToSettlementSettlement < ActiveRecord::Migration
  def change
    add_column :settlement_settlements, :exp_production_rate,           :decimal, :default => 0.0
    add_column :settlement_settlements, :exp_production_rate_buildings, :decimal, :default => 0.0
  end
end
