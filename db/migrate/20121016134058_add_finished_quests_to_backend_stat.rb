class AddFinishedQuestsToBackendStat < ActiveRecord::Migration
  def change
    add_column :backend_stats, :day_finished_quests,   :integer, :default => 0, :null => false
    add_column :backend_stats, :month_finished_quests, :integer, :default => 0, :null => false
  end
end
