class AddDayTenMinutesToBackendStat < ActiveRecord::Migration
  def change
    add_column :backend_stats, :month_num_ten_minutes, :integer, :default => 0, :null => false
    add_column :backend_stats, :day_num_ten_minutes, :integer, :default => 0, :null => false
  end
end
