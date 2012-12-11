require 'uri'

class Backend::SignInLogEntry < ActiveRecord::Base
  
  belongs_to :character, :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :sign_ins
  
  before_save :determine_referer_from_url
  before_save :determine_google_params_from_request_url
  
  
  protected
  
    def determine_referer_from_url
      self.referer = URI.parse(self.referer_url).host   unless self.referer_url.blank?
    end
  
    def determine_google_params_from_request_url
      uri = URI.parse(self.request_url)   unless self.request_url.blank?
      params = Rack::Utils.parse_query(uri.query)
      
      self.google_r = params['r'] unless params['r'].empty?
      self.google_k = params['k'] unless params['k'].empty?
      self.google_p = params['p'] unless params['p'].empty?
      self.google_n = params['n'] unless params['n'].empty?
    end
  
end
