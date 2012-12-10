class RemoveLikeCapacityFromFundamentalResourcePool < ActiveRecord::Migration
  def up
    remove_column :fundamental_resource_pools, :like_capacity
    remove_column :fundamental_resource_pools, :like_production_rate
    remove_column :fundamental_resource_pools, :like_bonus_effects
    remove_column :fundamental_resource_pools, :dislike_capacity
    remove_column :fundamental_resource_pools, :dislike_production_rate
    remove_column :fundamental_resource_pools, :dislike_bonus_effects
  end

  def down
    add_column :fundamental_resource_pools, :like_capacity, :decimal, :default => 0.0
    add_column :fundamental_resource_pools, :like_production_rate, :decimal, :default => 0.0
    add_column :fundamental_resource_pools, :like_bonus_effects, :decimal, :default => 0.0
    add_column :fundamental_resource_pools, :dislike_capacity, :decimal, :default => 0.0
    add_column :fundamental_resource_pools, :dislike_production_rate, :decimal, :default => 0.0
    add_column :fundamental_resource_pools, :dislike_bonus_effects, :decimal, :default => 0.0
  end
end
