class CreateMilitaryBattleRounds < ActiveRecord::Migration
  def change
    create_table :military_battle_rounds do |t|
      t.integer :battle_id
      t.integer :round_num
      t.datetime :executed_at

      t.timestamps
    end
  end
end
