class ChangeExperienceGainedTypeOfMilitaryBattleCharacterResult < ActiveRecord::Migration
  def up
    change_column :military_battle_character_results, :experience_gained, :decimal, { :default => 0.0, :null => false }
  end
  
  def down
    change_column :military_battle_character_results, :experience_gained, :integer, { :default => 0, :null => false }
  end
end
