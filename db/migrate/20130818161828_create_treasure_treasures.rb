class CreateTreasureTreasures < ActiveRecord::Migration
  def change
    create_table :treasure_treasures do |t|
      t.integer :character_id
      t.integer :difficulty
      t.integer :level
      t.integer :catagory
      t.decimal :latitude
      t.decimal :longitutde
      t.decimal :distance
      t.integer :experience_rewarud

      t.timestamps
    end
  end
end
