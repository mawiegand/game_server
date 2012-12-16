class AddCounterCacheToBackendPartnerSite < ActiveRecord::Migration
  def up
    Backend::PartnerSite.reset_column_information
    
    Backend::PartnerSite.all.each do |site|
      Backend::PartnerSite.reset_counters(site.id, :sign_ups)
    end
  end
  
  def down
  end
end
