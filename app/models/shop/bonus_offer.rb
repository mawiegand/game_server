class Shop::BonusOffer < ActiveRecord::Base
  
  def credit_to(character)
    
    # check if same effects is already active
    if false
    # extend effect
    # extend event
    else
      effect = Effect::ResourceEffect.create_with_offer(self)
        
      # event for effect
      event = effect.create_event(
        character: character,
        execute_at: effect.finished_at,
        event_type: "resource_effect",
        local_event_id: effect.id,
      )
      
      # add global effects to resource pool
      character.resource_pool.add_effect_transaction(effect)
    end
  end
  
end
