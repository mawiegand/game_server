class Effect::ResourceEffect < ActiveRecord::Base
  
  has_one    :event,     :class_name => "Event::Event", :foreign_key => "local_event_id",  :dependent => :destroy, :conditions => "event_type = 'resource_effect'"
  belongs_to :character, :class_name => "Fundamental::Character", :foreign_key => "character_id"  

  # creates resource effect from bonus offer 
  def self.create_with_offer(offer)
    Effect::ResourceEffect.create({
      bonus: offer.bonus,
      character_id: offer.character_id,
      resource_id: offer.resource_id,
      finished_at: Time.now + (offer.duration * 3600), 
    })
  end
end
