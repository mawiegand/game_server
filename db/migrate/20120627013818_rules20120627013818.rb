class Rules20120627013818 < ActiveRecord::Migration
  def change
    add_column :fundamental_resource_pools,   :resource_wood_global_effects,   :decimal,  {:default=>0.0}    
    add_column :fundamental_resource_pools,   :resource_stone_global_effects,   :decimal,  {:default=>0.0}    
    add_column :fundamental_resource_pools,   :resource_fur_global_effects,   :decimal,  {:default=>0.0}    
    add_column :fundamental_resource_pools,   :resource_cash_global_effects,   :decimal,  {:default=>0.0}    
  end
end
