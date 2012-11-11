require 'uri'

class Backend::SignInLogEntry < ActiveRecord::Base
  
  belongs_to :character, :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :sign_ins
  
  before_save :determine_referer_from_url
  
  
  protected
  
    def determine_referer_from_url
      self.referer = URI.parse(self.referer_url).host   unless self.referer_url.blank?
    end
  
end
