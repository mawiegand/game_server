class AddDirectRefererUrlToBackendSignInLogEntry < ActiveRecord::Migration
  def change
    add_column :backend_sign_in_log_entries, :direct_referer_url, :text
  end
end
