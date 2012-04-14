class CreateFundamentalAllianceShouts < ActiveRecord::Migration
  def change
    create_table :fundamental_alliance_shouts do |t|
      t.integer :character_id
      t.integer :alliance_id
      t.boolean :deleted
      t.boolean :reported
      t.string :message

      t.timestamps
    end
  end
end
