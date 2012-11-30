class AddParticipantToMilitaryBattleParticipantResult < ActiveRecord::Migration
  def change
    add_column :military_battle_participant_results, :participant_id, :integer
  end
end
