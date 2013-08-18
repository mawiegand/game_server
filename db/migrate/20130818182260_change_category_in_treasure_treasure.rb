class ChangeCategoryInTreasureTreasure < ActiveRecord::Migration
  def up
    remove_column :treasure_treasures, :catagory
    add_column :treasure_treasures, :category, :integer
  end

  def down
    remove_column :treasure_treasures, :category
    add_column :treasure_treasures, :catagory, :integer
  end
end
