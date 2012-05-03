class AddKillsAndVictoriesToMilitaryArmies < ActiveRecord::Migration
  def change
    add_column :military_armies, :kills, :integer
    add_column :military_armies, :victories, :integer
  end
end
