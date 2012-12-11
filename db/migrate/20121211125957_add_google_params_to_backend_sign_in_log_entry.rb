class AddGoogleParamsToBackendSignInLogEntry < ActiveRecord::Migration
  def change
    add_column :backend_sign_in_log_entries, :google_r, :text
    add_column :backend_sign_in_log_entries, :google_k, :text
    add_column :backend_sign_in_log_entries, :google_p, :text
    add_column :backend_sign_in_log_entries, :google_n, :text
  end
end
