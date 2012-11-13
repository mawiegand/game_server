class AddSignUpToBackendSignInLogEntry < ActiveRecord::Migration
  def change
    add_column :backend_sign_in_log_entries, :sign_up, :boolean, :default => false, :null => false
  end
end
