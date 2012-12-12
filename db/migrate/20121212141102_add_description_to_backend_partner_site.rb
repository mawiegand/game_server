class AddDescriptionToBackendPartnerSite < ActiveRecord::Migration
  def change
    add_column :backend_partner_sites, :description, :string
  end
end
