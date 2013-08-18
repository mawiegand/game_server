class FixTypoInTreasureTreasure < ActiveRecord::Migration
  def change
    rename_column :treasure_treasures, :experience_rewarud, :experience_reward
  end
end
