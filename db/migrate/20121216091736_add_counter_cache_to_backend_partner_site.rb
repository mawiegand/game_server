class AddCounterCacheToBackendPartnerSite < ActiveRecord::Migration
  def up
    Backend::PartnerSite.reset_column_information
    
    Backend::PartnerSite.all.each do |s|
      s.sign_ups_count = s.sign_ups.count
      s.save
    end
  end
  
  def down
  end
end
