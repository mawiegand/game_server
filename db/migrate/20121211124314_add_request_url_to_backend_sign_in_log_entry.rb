class AddRequestUrlToBackendSignInLogEntry < ActiveRecord::Migration
  def change
    add_column :backend_sign_in_log_entries, :request_url, :text
  end
end
