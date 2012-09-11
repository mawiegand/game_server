class AddFunnelToBackendStat < ActiveRecord::Migration
  def change
    add_column :backend_stats, :month_num_registered, :integer
    add_column :backend_stats, :month_num_logged_in_once, :integer
    add_column :backend_stats, :month_num_logged_in_two_days, :integer
    add_column :backend_stats, :month_num_active, :integer
    add_column :backend_stats, :month_num_long_term_active, :integer
    add_column :backend_stats, :month_num_paying, :integer
  end
end
