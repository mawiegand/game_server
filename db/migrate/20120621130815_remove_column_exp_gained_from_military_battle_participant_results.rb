class RemoveColumnExpGainedFromMilitaryBattleParticipantResults < ActiveRecord::Migration
  def change
  	remove_column :military_battle_participant_results, :exp_gained
  end
end
