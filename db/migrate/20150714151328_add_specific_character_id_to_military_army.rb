class AddSpecificCharacterIdToMilitaryArmy < ActiveRecord::Migration
  def change
    add_column :military_armies, :specific_character_id, :integer
  end
end
