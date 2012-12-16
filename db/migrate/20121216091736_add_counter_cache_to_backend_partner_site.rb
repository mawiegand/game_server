class AddCounterCacheToBackendPartnerSite < ActiveRecord::Migration
  def up
    Backend::PartnerSite.all.each do |site|
      Backend::PartnerSite.reset_counters(site.id, :signups_count)
    end
  end
  
  def down
  end
end
