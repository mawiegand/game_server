require 'uri'

class Backend::SignInLogEntry < ActiveRecord::Base
  
  belongs_to :character,     :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :sign_ins
  belongs_to :partner_site,  :class_name => "Backend::PartnerSite",   :foreign_key => "partner_site_id", :inverse_of => :sign_ins
  
  before_save :determine_referer_from_url
  before_save :determine_tracking_params_from_request_url
  before_save :add_partner_site

  protected
  
    def determine_referer_from_url
      self.referer = URI.parse(self.referer_url).host   unless self.referer_url.blank?
    end
  
    def determine_tracking_params_from_request_url
      uri = URI.parse(self.request_url) unless self.request_url.blank?
      
      unless uri.query.blank?
        params = Rack::Utils.parse_query(uri.query)
        
        self.r = params['r'][0..1] unless params['r'].empty?
        self.k = params['k'] unless params['k'].empty?
        self.p = params['p'] unless params['p'].empty?
        self.n = params['n'] unless params['n'].empty?
      end
    end
  
    def add_partner_site
      self.partner_site = Backend::PartnerSite.find_by_referer_and_r(self.referer, self.r) unless self.r.nil?
      self.partner_site = Backend::PartnerSite.find_by_referer_and_r(self.referer, '') if self.partner_site.nil?
    end  
  
end
