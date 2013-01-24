class AddTypeIdToFundamentalArtifacts < ActiveRecord::Migration
  def change
    add_column :fundamental_artifacts, :type_id, :integer
  end
end
