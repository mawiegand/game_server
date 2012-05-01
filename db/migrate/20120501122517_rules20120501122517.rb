class Rules20120501122517 < ActiveRecord::Migration
  def change
    add_column :military_armies,   :unitcategory_infantry_strength,   :decimal
    add_column :military_armies,   :unitcategory_cavalry_strength,   :decimal
    add_column :military_armies,   :unitcategory_artillery_strength,   :decimal
    add_column :military_battle_factions,   :unitcategory_infantry_strength,   :decimal
    add_column :military_battle_factions,   :unitcategory_cavalry_strength,   :decimal
    add_column :military_battle_factions,   :unitcategory_artillery_strength,   :decimal
  end
end
