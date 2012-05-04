class CreateMilitaryBattleFactionResults < ActiveRecord::Migration
  def change
    create_table :military_battle_faction_results do |t|
      t.integer :battle_id
      t.integer :round_id
      t.integer :faction_id
      t.integer :leader_id
      t.string :given_command
      t.string :executed_command

      t.timestamps
    end
  end
end
