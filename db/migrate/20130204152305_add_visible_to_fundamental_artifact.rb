class AddVisibleToFundamentalArtifact < ActiveRecord::Migration
  def change
    add_column :fundamental_artifacts, :visible, :boolean
  end
end
