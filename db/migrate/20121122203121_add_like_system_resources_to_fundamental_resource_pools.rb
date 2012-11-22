class AddLikeSystemResourcesToFundamentalResourcePools < ActiveRecord::Migration
  def change
    add_column :fundamental_resource_pools, :resource_like_amount, :decimal, :default => 0.0
    add_column :fundamental_resource_pools, :resource_like_capacity, :decimal, :default => 0.0
    add_column :fundamental_resource_pools, :resource_like_production_rate, :decimal, :default => 0.0
    add_column :fundamental_resource_pools, :resource_like_production_bonus_effects, :decimal, :default => 0.0
    add_column :fundamental_resource_pools, :resource_dislike_amount, :decimal, :default => 0.0
    add_column :fundamental_resource_pools, :resource_dislike_capacity, :decimal, :default => 0.0
    add_column :fundamental_resource_pools, :resource_dislike_production_rate, :decimal, :default => 0.0
    add_column :fundamental_resource_pools, :resource_dislike_production_bonus_effects, :decimal, :default => 0.0
  end
end
