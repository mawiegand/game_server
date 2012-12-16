class AddCounterCacheToBackendPartnerSite < ActiveRecord::Migration
  def up
    Backend::PartnerSite.reset_column_information
    
    Backend::PartnerSite.all.each do |site|
      Backend::PartnerSite.update_counters(site.id, :signups_count => site.sign_ups.length)
    end
  end
  
  def down
  end
end
