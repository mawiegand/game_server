class Rules20120612184015 < ActiveRecord::Migration
  def change
    add_column :settlement_settlements,   :resource_wood_capacity,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_wood_production_rate,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_wood_base_production,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_wood_production_bonus,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_wood_production_bonus_buildings,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_wood_production_bonus_sciences,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_wood_production_bonus_alliance,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_wood_production_bonus_effects,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_stone_capacity,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_stone_production_rate,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_stone_base_production,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_stone_production_bonus,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_stone_production_bonus_buildings,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_stone_production_bonus_sciences,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_stone_production_bonus_alliance,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_stone_production_bonus_effects,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_fur_capacity,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_fur_production_rate,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_fur_base_production,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_fur_production_bonus,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_fur_production_bonus_buildings,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_fur_production_bonus_sciences,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_fur_production_bonus_alliance,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_fur_production_bonus_effects,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_cash_capacity,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_cash_production_rate,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_cash_base_production,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_cash_production_bonus,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_cash_production_bonus_buildings,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_cash_production_bonus_sciences,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_cash_production_bonus_alliance,   :decimal,  {:default=>0.0}    
    add_column :settlement_settlements,   :resource_cash_production_bonus_effects,   :decimal,  {:default=>0.0}    
    add_column :fundamental_resource_pools,   :resource_wood_amount,   :decimal,  {:default=>0.0}    
    add_column :fundamental_resource_pools,   :resource_wood_capacity,   :decimal,  {:default=>0.0}    
    add_column :fundamental_resource_pools,   :resource_wood_production_rate,   :decimal,  {:default=>0.0}    
    add_column :fundamental_resource_pools,   :resource_stone_amount,   :decimal,  {:default=>0.0}    
    add_column :fundamental_resource_pools,   :resource_stone_capacity,   :decimal,  {:default=>0.0}    
    add_column :fundamental_resource_pools,   :resource_stone_production_rate,   :decimal,  {:default=>0.0}    
    add_column :fundamental_resource_pools,   :resource_fur_amount,   :decimal,  {:default=>0.0}    
    add_column :fundamental_resource_pools,   :resource_fur_capacity,   :decimal,  {:default=>0.0}    
    add_column :fundamental_resource_pools,   :resource_fur_production_rate,   :decimal,  {:default=>0.0}    
    add_column :fundamental_resource_pools,   :resource_cash_amount,   :decimal,  {:default=>0.0}    
    add_column :fundamental_resource_pools,   :resource_cash_capacity,   :decimal,  {:default=>0.0}    
    add_column :fundamental_resource_pools,   :resource_cash_production_rate,   :decimal,  {:default=>0.0}    
  end
end
