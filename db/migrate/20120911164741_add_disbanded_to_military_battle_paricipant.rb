class AddDisbandedToMilitaryBattleParicipant < ActiveRecord::Migration
  def change
    add_column :military_battle_participants, :disbanded, :boolean
  end
end
