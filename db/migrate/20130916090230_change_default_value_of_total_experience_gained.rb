class ChangeDefaultValueOfTotalExperienceGained < ActiveRecord::Migration
  def change
    change_column :military_battle_participants, :total_experience_gained, :integer, :default => 0, :null => false
  end
end
