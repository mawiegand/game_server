class AddGrossToBackendStat < ActiveRecord::Migration
  def change
    add_column :backend_stats, :mgross, :decimal, :default => 0.0, :null => false
    add_column :backend_stats, :wgross, :decimal, :default => 0.0, :null => false
    add_column :backend_stats, :dgross, :decimal, :default => 0.0, :null => false
    add_column :backend_stats, :day_gross, :decimal, :default => 0.0, :null => false
    add_column :backend_stats, :month_gross, :decimal, :default => 0.0, :null => false
  end
end
