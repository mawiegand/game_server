class Backend::PartnerSite < ActiveRecord::Base
  
  belongs_to  :partner,  :class_name => "Backend::User",  :foreign_key => "backend_user_id",  :inverse_of => :partner_sites

end
