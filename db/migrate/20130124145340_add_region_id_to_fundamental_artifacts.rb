class AddRegionIdToFundamentalArtifacts < ActiveRecord::Migration
  def change
    add_column :fundamental_artifacts, :region_id, :integer
  end
end
