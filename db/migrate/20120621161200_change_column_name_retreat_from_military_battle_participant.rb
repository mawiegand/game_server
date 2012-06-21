class ChangeColumnNameRetreatFromMilitaryBattleParticipant < ActiveRecord::Migration
  def change
  	rename_column :military_battle_participants, :retreat, :retreated
  	rename_column :military_battle_participants, :retreat_to_region_id, :retreated_to_region_id
  	rename_column :military_battle_participants, :retreat_to_location_id, :retreated_to_location_id
  end
end
