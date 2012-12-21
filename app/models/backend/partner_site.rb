class Backend::PartnerSite < ActiveRecord::Base
  
  belongs_to  :partner,    :class_name => "Backend::User",            :foreign_key => "backend_user_id",  :inverse_of => :partner_sites
  has_many    :sign_ins,   :class_name => "Backend::SignInLogEntry",  :foreign_key => "partner_site_id",  :inverse_of => :partner_site
  has_many    :sign_ups,   :class_name => "Backend::SignInLogEntry",  :foreign_key => "partner_site_id",  :conditions => ["sign_up=?", true]
  has_many    :characters, :through => :sign_ups, :uniq => true
  
  def self.update_all_partner_sites
    Backend::PartnerSite.all.each do |site|
      site.recalc_all_stats
      site.save
    end
  end
  
  def recalc_all_stats
    self.sign_ups_count         = sign_ups.count
    self.playtime               = characters.sum(:playtime)
    self.gross                  = characters.sum(:gross)
#   self.revenue                = characters.sum(:revenue)

    self.total_churned          = characters.churned.count    
    self.total_logged_in_once   = characters.logged_in_once.count    
    self.total_ten_minutes      = characters.ten_minutes.count    
    self.total_second_day       = characters.second_day.count    
    self.total_active           = characters.active.count    
    self.total_long_term_active = characters.long_term_active.count    
    self.total_paying           = characters.paying.count    
  end

end
