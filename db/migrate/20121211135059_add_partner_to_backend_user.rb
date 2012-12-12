class AddPartnerToBackendUser < ActiveRecord::Migration
  def change
    add_column :backend_users, :partner, :boolean
  
    Backend::User.all.each do |user|
      user.partner = user.admin
      user.save
    end
  end
end
