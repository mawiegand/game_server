class AddWinnerToMilitaryBattleFaction < ActiveRecord::Migration
  def change
    add_column :military_battle_factions, :winner, :boolean, :default => false
  end
end
