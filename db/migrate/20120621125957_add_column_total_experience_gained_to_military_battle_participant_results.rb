class AddColumnTotalExperienceGainedToMilitaryBattleParticipantResults < ActiveRecord::Migration
  def change
  	add_column :military_battle_participant_results, :exp_gained, :integer, { default: 0 }
  	rename_column :military_battle_participants, :exp_gained, :total_exp_gained
  end
end
