class RenameColumnActiveToInitiatedInFundamentalArtifact < ActiveRecord::Migration
  def change
    rename_column :fundamental_artifacts, :active, :initiated
  end
end
