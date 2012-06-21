class AddColumnTotalExperienceGainedToMilitaryBattleParticipants < ActiveRecord::Migration
  def change
  	add_column :military_battle_participants, :exp_gained, :integer, { default: 0 }
  end
end
