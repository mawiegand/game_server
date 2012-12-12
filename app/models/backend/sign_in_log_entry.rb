require 'uri'

class Backend::SignInLogEntry < ActiveRecord::Base
  
  belongs_to :character,     :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :sign_ins
  belongs_to :partner_site,  :class_name => "Backend::PartnerSite",   :foreign_key => "partner_site_id", :inverse_of => :sign_ins
  
  before_save :determine_referer_from_url
  before_save :determine_google_params_from_request_url
  
  scope :partner, where([
    Rails.env.development? || Rails.env.test? ?
      "datetime('now', '-? hours') < created_at AND created_at < datetime('now', '-? hours') AND last_login_at < datetime('now', '-? hours')" :
      "NOW() - INTERVAL '? hour'   < created_at AND created_at < NOW() - INTERVAL '? hour'   AND last_login_at < NOW() - INTERVAL '? hour'",
    44, 24, 20  # 44h ago > created > 24h ago and last login > 20h ago 
  ])
  
  
  protected
  
    def determine_referer_from_url
      self.referer = URI.parse(self.referer_url).host   unless self.referer_url.blank?
    end
  
    def determine_google_params_from_request_url
      logger.debug "---> " + self.request_url.inspect
      uri = URI.parse(self.request_url) unless self.request_url.blank?
      
      unless uri.blank?
        params = Rack::Utils.parse_query(uri.query)
        
        self.google_r = params['r'] unless params['r'].empty?
        self.google_k = params['k'] unless params['k'].empty?
        self.google_p = params['p'] unless params['p'].empty?
        self.google_n = params['n'] unless params['n'].empty?
      end
    end
  
end
