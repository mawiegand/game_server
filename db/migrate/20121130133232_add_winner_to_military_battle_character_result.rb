class AddWinnerToMilitaryBattleCharacterResult < ActiveRecord::Migration
  def change
    add_column :military_battle_character_results, :winner, :boolean, :default => false, :null => false
  end
end
