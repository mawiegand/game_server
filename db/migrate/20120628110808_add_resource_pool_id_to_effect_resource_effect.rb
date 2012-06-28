class AddResourcePoolIdToEffectResourceEffect < ActiveRecord::Migration
  def change
    add_column :effect_resource_effects, :resource_pool_id, :integer
  end
end
