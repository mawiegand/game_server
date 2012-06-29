class Rules20120629121224 < ActiveRecord::Migration
  def change
    add_column :settlement_settlements,   :resource_wood_production_bonus_global_effects,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_stone_production_bonus_global_effects,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_fur_production_bonus_global_effects,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_cash_production_bonus_global_effects,   :decimal,  {:default=>0.0}    
  end
end
