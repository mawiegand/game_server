class AddPartnerSiteToBackendSignInLogEntries < ActiveRecord::Migration
  def change
    add_column :backend_sign_in_log_entries, :partner_site_id, :integer
  end
end
