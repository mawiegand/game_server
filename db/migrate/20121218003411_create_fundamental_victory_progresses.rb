class CreateFundamentalVictoryProgresses < ActiveRecord::Migration
  def change
    create_table :fundamental_victory_progresses do |t|
      t.integer  :victory_type, :null => false
      t.integer  :alliance_id
      t.datetime :first_fulfilled_at
      t.integer  :fulfillment_count, :default => 0, :null => false

      t.timestamps
    end
  end
end
