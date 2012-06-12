class CreateFundamentalResourcePools < ActiveRecord::Migration
  def change
    create_table :fundamental_resource_pools do |t|
      t.integer :character_id
      t.datetime :locked_at
      t.string :locked_by
      t.string :locked_reason

      t.timestamps
    end
  end
end
