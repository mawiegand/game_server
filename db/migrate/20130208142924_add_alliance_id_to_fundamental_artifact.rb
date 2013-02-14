class AddAllianceIdToFundamentalArtifact < ActiveRecord::Migration
  def change
    add_column :fundamental_artifacts, :alliance_id, :integer
  end
end
