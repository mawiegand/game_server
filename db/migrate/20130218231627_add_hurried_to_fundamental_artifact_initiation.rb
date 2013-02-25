class AddHurriedToFundamentalArtifactInitiation < ActiveRecord::Migration
  def change
    add_column :fundamental_artifact_initiations, :hurried, :boolean, :default => false, :null => false
  end
end
