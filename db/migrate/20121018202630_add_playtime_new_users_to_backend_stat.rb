class AddPlaytimeNewUsersToBackendStat < ActiveRecord::Migration
  def change
    add_column :backend_stats, :dtimenew, :integer, :default => 0, :null => false
    add_column :backend_stats, :wtimenew, :integer, :default => 0, :null => false
    add_column :backend_stats, :mtimenew, :integer, :default => 0, :null => false
  end
end
