class AddDefaultValueToMilitaryBattleFactionsAttribute < ActiveRecord::Migration
  def up
    remove_column  :military_battle_factions,   :unitcategory_special_strength 
    add_column     :military_battle_factions,   :unitcategory_special_strength,   :decimal,  {:default => 0.0, :null => false}    
  end

  def down
    remove_column  :military_battle_factions,   :unitcategory_special_strength 
    add_column     :military_battle_factions,   :unitcategory_special_strength,   :decimal,  {}    
  end
end
