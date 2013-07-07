class AddTutorialCompletionStatsToBackendStat < ActiveRecord::Migration
  def change
    add_column :backend_stats, :month_num_2nd_day,                      :integer, :default => 0, :null => false
    add_column :backend_stats, :month_num_tutorial_completed,           :integer, :default => 0, :null => false
    add_column :backend_stats, :month_num_tutorial_completed_first_day, :integer, :default => 0, :null => false
    add_column :backend_stats, :day_num_2nd_day,                        :integer, :default => 0, :null => false
    add_column :backend_stats, :day_num_tutorial_completed,             :integer, :default => 0, :null => false
    add_column :backend_stats, :day_num_tutorial_completed_first_day,   :integer, :default => 0, :null => false
    add_column :fundamental_characters, :logged_in_on_second_day,       :boolean, :default => false, :null => false
  end
end
