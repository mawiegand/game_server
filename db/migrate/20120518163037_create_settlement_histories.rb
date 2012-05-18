class CreateSettlementHistories < ActiveRecord::Migration
  def change
    create_table :settlement_histories do |t|
      t.integer :settlement_id
      t.string :event_type
      t.integer :owner_id
      t.string :owner_name
      t.integer :alliance_id
      t.string :alliance_tag
      t.integer :level
      t.integer :points

      t.timestamps
    end
  end
end
