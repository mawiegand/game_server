class AddNumRoundsToMilitaryBattleParticipant < ActiveRecord::Migration
  def change
    add_column :military_battle_participants, :num_rounds, :integer, :default => 0, :null => false
  end
end
