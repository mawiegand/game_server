class AddTrackingParamToBackendPartnerSite < ActiveRecord::Migration
  def change
    add_column :backend_partner_sites, :r, :string
  end
end
