class Effect::ResourceEffect < ActiveRecord::Base
  
  has_one    :event,  :class_name => "Event::Event",        :foreign_key => "local_event_id",  :dependent => :destroy

  # creates resource effect from bonus offer 
  def self.create_with_offer(offer)
    Effect::ResourceEffect.create({
      bonus: offer.bonus,
      resource_id: offer.resource_id,
      finished_at: Time.now + (offer.duration * 3600), 
    })
  end
end
