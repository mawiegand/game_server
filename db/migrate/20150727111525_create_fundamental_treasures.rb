class CreateFundamentalTreasures < ActiveRecord::Migration
  def change
    create_table :fundamental_treasures do |t|
      t.integer :location_id
      t.integer :army_id
      t.integer :region_id
      t.integer :specific_character_id
      t.decimal :resource_stone_reward, default: 0
      t.decimal :resource_wood_reward, default: 0
      t.decimal :resource_fur_reward, default: 0
      t.decimal :resource_cash_reward, default: 0

      t.timestamps
    end
  end
end
