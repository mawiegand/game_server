class ChangeColumnNameTotalExpGainedFromMilitaryBattleParticipant < ActiveRecord::Migration
  def change
  	rename_column :military_battle_participants, :total_exp_gained, :total_experience_gained
  end
end
