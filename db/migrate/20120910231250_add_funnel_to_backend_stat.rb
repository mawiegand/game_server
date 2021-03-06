class AddFunnelToBackendStat < ActiveRecord::Migration
  def change
    add_column :backend_stats, :month_num_registered, :integer, :default => 0, :null => false
    add_column :backend_stats, :month_num_logged_in_once, :integer, :default => 0, :null => false
    add_column :backend_stats, :month_num_logged_in_two_days, :integer, :default => 0, :null => false
    add_column :backend_stats, :month_num_active, :integer, :default => 0, :null => false
    add_column :backend_stats, :month_num_long_term_active, :integer, :default => 0, :null => false
    add_column :backend_stats, :month_num_paying, :integer, :default => 0, :null => false
  end
end
