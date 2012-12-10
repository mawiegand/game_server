class RenameLikeDislikeResourceToFundamentalResourcePools < ActiveRecord::Migration
  def change
    rename_column :fundamental_resource_pools, :resource_like_amount, :like_amount
    rename_column :fundamental_resource_pools, :resource_like_capacity, :like_capacity
    rename_column :fundamental_resource_pools, :resource_like_production_rate, :like_production_rate
    rename_column :fundamental_resource_pools, :resource_like_production_bonus_effects, :like_bonus_effects
    rename_column :fundamental_resource_pools, :resource_dislike_amount, :dislike_amount
    rename_column :fundamental_resource_pools, :resource_dislike_capacity, :dislike_capacity
    rename_column :fundamental_resource_pools, :resource_dislike_production_rate, :dislike_production_rate
    rename_column :fundamental_resource_pools, :resource_dislike_production_bonus_effects, :dislike_bonus_effects
  end
end
