class RemoveResourceWoodGlobalEffectsFromFundamentalResourcePool < ActiveRecord::Migration
  
  def up
    remove_column :fundamental_resource_pools,    :resource_wood_global_effects
    remove_column :fundamental_resource_pools,    :resource_stone_global_effects
    remove_column :fundamental_resource_pools,    :resource_fur_global_effects
    remove_column :fundamental_resource_pools,    :resource_cash_global_effects
  end

  def down
    add_column    :fundamental_resource_pools,    :resource_wood_global_effects,     :decimal,   {  :default => 0.0 }
    add_column    :fundamental_resource_pools,    :resource_stone_global_effects,    :decimal,   {  :default => 0.0 }
    add_column    :fundamental_resource_pools,    :resource_fur_global_effects,      :decimal,   {  :default => 0.0 }
    add_column    :fundamental_resource_pools,    :resource_cash_global_effects,     :decimal,   {  :default => 0.0 }
  end
  
end
