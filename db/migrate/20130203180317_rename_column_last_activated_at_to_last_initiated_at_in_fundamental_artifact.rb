class RenameColumnLastActivatedAtToLastInitiatedAtInFundamentalArtifact < ActiveRecord::Migration
  def change
    rename_column :fundamental_artifacts, :last_activated_at, :last_initiated_at
  end
end
