class AddArmyNameToMilitaryBattleParticipants < ActiveRecord::Migration
  def change
  	add_column :military_battle_participants, :army_name, :string
  end
end
