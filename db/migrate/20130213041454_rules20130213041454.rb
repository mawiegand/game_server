class Rules20130213041454 < ActiveRecord::Migration
  def change
    add_column :fundamental_resource_pools,   :resource_stone_production_bonus_alliance,   :decimal,  {:default=>0.0}    
    add_column :fundamental_resource_pools,   :resource_wood_production_bonus_alliance,   :decimal,  {:default=>0.0}    
    add_column :fundamental_resource_pools,   :resource_fur_production_bonus_alliance,   :decimal,  {:default=>0.0}    
    add_column :fundamental_resource_pools,   :resource_cash_production_bonus_alliance,   :decimal,  {:default=>0.0}    
  end
end
