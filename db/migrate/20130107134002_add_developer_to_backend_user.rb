class AddDeveloperToBackendUser < ActiveRecord::Migration
  def change
    add_column :backend_users, :developer, :boolean, :default => false, :null => false
  end
end
