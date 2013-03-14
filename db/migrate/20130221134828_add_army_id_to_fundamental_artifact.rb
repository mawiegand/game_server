class AddArmyIdToFundamentalArtifact < ActiveRecord::Migration
  def change
    add_column :fundamental_artifacts, :army_id, :integer
  end
end
