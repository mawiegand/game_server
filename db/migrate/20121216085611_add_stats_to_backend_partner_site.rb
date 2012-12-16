class AddStatsToBackendPartnerSite < ActiveRecord::Migration
  def up
    add_column :backend_partner_sites, :signups_count,          :integer, :default => 0
    add_column :backend_partner_sites, :playtime,               :decimal, :default => 0.0, :null => false
    add_column :backend_partner_sites, :gross,                  :decimal, :default => 0.0, :null => false
    add_column :backend_partner_sites, :revenue,                :decimal, :default => 0.0, :null => false
    add_column :backend_partner_sites, :total_churned,          :integer, :default => 0,   :null => false
    add_column :backend_partner_sites, :total_logged_in_once,   :integer, :default => 0,   :null => false
    add_column :backend_partner_sites, :total_ten_minutes,      :integer, :default => 0,   :null => false
    add_column :backend_partner_sites, :total_second_day,       :integer, :default => 0,   :null => false
    add_column :backend_partner_sites, :total_active,           :integer, :default => 0,   :null => false
    add_column :backend_partner_sites, :total_long_term_active, :integer, :default => 0,   :null => false
    add_column :backend_partner_sites, :total_paying,           :integer, :default => 0,   :null => false
    
    Backend::PartnerSite.all.each do |site|
      Backend::PartnerSite.reset_counters(site.id, :signups_count)
    end
  end
  
  def down
    remove_column :backend_partner_sites, :signup_counter_cache
    remove_column :backend_partner_sites, :playtime
    remove_column :backend_partner_sites, :gross
    remove_column :backend_partner_sites, :revenue
    remove_column :backend_partner_sites, :total_churned
    remove_column :backend_partner_sites, :total_logged_in_once
    remove_column :backend_partner_sites, :total_ten_minutes
    remove_column :backend_partner_sites, :total_second_day
    remove_column :backend_partner_sites, :total_active
    remove_column :backend_partner_sites, :total_long_term_active
    remove_column :backend_partner_sites, :total_paying
  end
end
