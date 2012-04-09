class CreateFundamentalCharacters < ActiveRecord::Migration
  def change
    create_table :fundamental_characters do |t|
      t.string :identifier
      t.boolean :premium_account
      t.string :name
      t.integer :lvel
      t.integer :exp
      t.integer :att
      t.integer :def
      t.integer :wins
      t.integer :losses
      t.integer :health_max
      t.float :health_present
      t.datetime :health_updated_at
      t.boolean :locked
      t.string :locked_by
      t.datetime :locked_at
      t.integer :skill_points
      t.integer :alliance_id
      t.string :alliance_tag
      t.integer :base_location_id
      t.integer :region_location_id

      t.timestamps
    end
  end
end
