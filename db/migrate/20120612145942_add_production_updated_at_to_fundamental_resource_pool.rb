class AddProductionUpdatedAtToFundamentalResourcePool < ActiveRecord::Migration
  def change
    add_column :fundamental_resource_pools, :productionUpdatedAt, :datetime
  end
end
