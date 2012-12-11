class AddPartnerToBackendUser < ActiveRecord::Migration
  def change
    add_column :backend_users, :partner, :boolean
  end
end
