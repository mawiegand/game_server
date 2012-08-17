class AddLostUsersToBackendStat < ActiveRecord::Migration
  def change
    add_column :backend_stats, :dlu, :integer
    add_column :backend_stats, :wlu, :integer
    add_column :backend_stats, :mlu, :integer
  end
end
