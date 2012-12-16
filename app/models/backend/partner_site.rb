class Backend::PartnerSite < ActiveRecord::Base
  
  belongs_to  :partner,   :class_name => "Backend::User",            :foreign_key => "backend_user_id",  :inverse_of => :partner_sites
  has_many    :sign_ins,  :class_name => "Backend::SignInLogEntry",  :foreign_key => "partner_site_id",  :inverse_of => :partner_site
  has_many    :sign_ups,  :class_name => "Backend::SignInLogEntry",  :foreign_key => "partner_site_id",  :inverse_of => :referer_site, :conditions => ["sign_up=?", true]
  has_many    :characters, :through => :sign_ups, :uniq => true

end
