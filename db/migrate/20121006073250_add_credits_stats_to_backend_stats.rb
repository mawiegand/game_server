class AddCreditsStatsToBackendStats < ActiveRecord::Migration
  def change
    add_column :backend_stats, :month_credits_spent, :integer, :default => 0, :null=> false
    add_column :backend_stats, :day_credits_spent, :integer, :default => 0, :null=> false
    add_column :backend_stats, :dcs, :integer, :default => 0, :null=> false
    add_column :backend_stats, :mcs, :integer, :default => 0, :null=> false
    add_column :backend_stats, :wcs, :integer, :default => 0, :null=> false
  end
end
