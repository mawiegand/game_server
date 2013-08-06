class Fundamental::Setting < ActiveRecord::Base

  belongs_to :owner, :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :setting


  def self.find_or_create_by_character(character)
    return nil    if character.nil?
    
    if character.setting.nil?
      character.create_setting({})   # fill with new default values
    end
    
    character.setting
  end
  
  
  def email_notifications_enabled?
    email_messages?
  end
  
  
  def experimental_enabled?
    owner.insider? && experimental?
  end
  
  
  def insider_newsletter_enabled?
    owner.insider? && insider_newsletter?
  end
    

end
