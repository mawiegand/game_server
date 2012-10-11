class Shop::PlatinumOffer < ActiveRecord::Base
  
  def credit_to(character)
    character.extend_premium_atomically(self.duration)
  end
  
end
