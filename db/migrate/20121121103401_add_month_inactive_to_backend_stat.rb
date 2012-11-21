class AddMonthInactiveToBackendStat < ActiveRecord::Migration
  def change
    add_column :backend_stats, :month_inactive, :integer, :default => 0, :null => false
    add_column :backend_stats, :day_inactive,   :integer, :default => 0, :null => false
  end
end
