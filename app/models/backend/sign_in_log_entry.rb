require 'uri'

class Backend::SignInLogEntry < ActiveRecord::Base
  
  belongs_to :character,     :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :sign_ins
  belongs_to :partner_site,  :class_name => "Backend::PartnerSite",   :foreign_key => "partner_site_id", :inverse_of => :sign_ins
  
  before_save :determine_referer_from_url
  before_save :determine_tracking_params_from_request_url
  before_save :add_partner_site
  
  scope :signups,         where(sign_up: true)
  scope :refered_by_host, lambda { |host| where("referer LIKE '%#{host}%']"]) }
  scope :refered_by_id,   lambda { |rid|  where(r: rid) }

  protected
  
    def determine_referer_from_url
      self.referer = URI.parse(self.referer_url).host   unless self.referer_url.blank?
    end
  
    def determine_tracking_params_from_request_url
      uri = URI.parse(self.request_url) unless self.request_url.blank?
      
      if !uri.nil? && !uri.query.blank?
        params = Rack::Utils.parse_query(uri.query)
        
        self.r = params['r'] if (params.has_key?('r') && !params['r'].empty?)
        self.k = params['k'] if (params.has_key?('k') && !params['k'].empty?)
        self.p = params['p'] if (params.has_key?('p') && !params['p'].empty?)
        self.n = params['n'] if (params.has_key?('n') && !params['n'].empty?)
      end
    end
  
    def add_partner_site
      self.partner_site = Backend::PartnerSite.find_by_r(self.r) unless self.r.nil?
      self.partner_site = Backend::PartnerSite.find_by_referer(self.referer) if self.partner_site.nil?
    end  
  
end
