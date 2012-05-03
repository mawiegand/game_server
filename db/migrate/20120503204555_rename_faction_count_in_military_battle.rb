class RenameFactionCountInMilitaryBattle < ActiveRecord::Migration
  def up
  end

  def change
    rename_column :military_battles, :factions_count, :battle_factions_count
    rename_column :military_battles, :rounds_count, :battle_rounds_count
  end
end
