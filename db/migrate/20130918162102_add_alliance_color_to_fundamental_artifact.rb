class AddAllianceColorToFundamentalArtifact < ActiveRecord::Migration
  def change
    add_column :fundamental_artifacts, :alliance_color, :integer
  end
end
