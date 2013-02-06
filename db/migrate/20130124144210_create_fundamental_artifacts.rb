class CreateFundamentalArtifacts < ActiveRecord::Migration
  def change
    create_table :fundamental_artifacts do |t|
      t.integer :location_id
      t.integer :settlement_id
      t.integer :owner_id
      t.boolean :active
      t.datetime :last_activated_at
      t.datetime :last_captured_at

      t.timestamps
    end
  end
end
