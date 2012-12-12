class AddTrackingParamsToBackendSignInLogEntry < ActiveRecord::Migration
  def change
    add_column :backend_sign_in_log_entries, :r, :text
    add_column :backend_sign_in_log_entries, :k, :text
    add_column :backend_sign_in_log_entries, :p, :text
    add_column :backend_sign_in_log_entries, :n, :text
  end
end
