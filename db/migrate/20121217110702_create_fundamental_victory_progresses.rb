class CreateFundamentalVictoryProgresses < ActiveRecord::Migration
  def change
    create_table :fundamental_victory_progresses do |t|
      t.integer :victory_type
      t.integer :alliance_id
      t.decimal :percentage
      t.decimal :days

      t.timestamps
    end
  end
end
