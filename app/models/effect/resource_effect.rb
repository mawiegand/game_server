class Effect::ResourceEffect < ActiveRecord::Base
  
  has_one    :event,     :class_name => "Event::Event", :foreign_key => "local_event_id",  :dependent => :destroy, :conditions => "event_type = 'resource_effect'"
  belongs_to :character, :class_name => "Fundamental::Character", :foreign_key => "character_id"  

  RESOURCE_EFFECT_TYPE_SHOP = 0

  # creates resource effect from bonus offer 
  def self.create_with_offer(offer)

  end
end
