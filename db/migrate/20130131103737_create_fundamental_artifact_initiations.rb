class CreateFundamentalArtifactInitiations < ActiveRecord::Migration
  def change
    create_table :fundamental_artifact_initiations do |t|
      t.integer :artifact_id
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps
    end
  end
end
