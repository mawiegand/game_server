class AddLazyProductionUpdatedAtToFundamentalResourcePools < ActiveRecord::Migration
  def change
    add_column :fundamental_resource_pools, :lazy_production_updated_at, :datetime
  end
end
