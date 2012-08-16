class AddTotalUsersToBackendStat < ActiveRecord::Migration
  def change
    add_column :backend_stats, :total_users, :integer
    add_column :backend_stats, :total_customers, :integer
    add_column :backend_stats, :active_customers, :integer
  end
end
