class CreateBackendPartnerSites < ActiveRecord::Migration
  def change
    create_table :backend_partner_sites do |t|
      t.integer :backend_user_id
      t.string :referer

      t.timestamps
    end
  end
end
