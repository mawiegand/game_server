class Shop::ResourceOffer < ActiveRecord::Base
  
  def credit_to(character)
    character.resource_pool.add_resource_atomically(self.resource_id, self.amount)
  end
  
end
