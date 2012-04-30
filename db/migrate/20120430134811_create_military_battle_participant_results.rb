class CreateMilitaryBattleParticipantResults < ActiveRecord::Migration
  def change
    create_table :military_battle_participant_results do |t|
      t.integer :battle_id
      t.integer :round_id
      t.integer :army_id
      t.integer :battle_faction_result_id
      t.boolean :retreat_tried
      t.boolean :retreat_succeeded
      t.integer :kills
      t.integer :experience_gained

      t.timestamps
    end
  end
end
