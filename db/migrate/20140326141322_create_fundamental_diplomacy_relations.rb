class CreateFundamentalDiplomacyRelations < ActiveRecord::Migration
  def change
    create_table :fundamental_diplomacy_relations do |t|
      t.integer :source_alliance_id
      t.integer :target_alliance_id
      t.integer :diplomacy_status
      t.boolean :initiator, :default => false

      t.timestamps
    end
  end
end
