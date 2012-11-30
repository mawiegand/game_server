class CreateMilitaryBattleCharacterResults < ActiveRecord::Migration
  def change
    create_table :military_battle_character_results do |t|
      t.integer :battle_id
      t.integer :character_id
      t.integer :faction_id
      t.integer :experience_gained,  :default => 0,      :null => false
      t.boolean :winner,             :default => false,  :nll => false

      t.timestamps
    end
  end
end
