class Rules20120803141019 < ActiveRecord::Migration
  def change
    add_column :settlement_settlements,   :resource_stone_production_tax_rate,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_wood_production_tax_rate,    :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_fur_production_tax_rate,     :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_cash_production_tax_rate,    :decimal,  {:default=>0.0}    
  end
end
