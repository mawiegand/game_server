class AddNewUsersToBackendStat < ActiveRecord::Migration
  def change
    add_column :backend_stats, :dnu, :integer
    add_column :backend_stats, :wnu, :integer
    add_column :backend_stats, :mnu, :integer
  end
end
