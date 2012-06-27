class Shop::BonusOffer < ActiveRecord::Base
  
  def credit_to(character)
    
    # check if same effects is already active
    effects = Effect::ResourceEffect.where(:character_id => character.id, :type_id => Effect::ResourceEffect::RESOURCE_EFFECT_TYPE_SHOP, :resource_id => self.resource_id)
    
    raise BadAccessError.new('more than one bonus active for same resource') if effects.count > 1
    
    if effects.count == 1
      effect = effects.first
      effect.finished_at += self.duration * 3600
      effect.save
      
      event = effect.event
      raise BadAccessError.new('more than one bonus active for same resource') if event.nil?
      event.execute_at += self.duration * 3600
      event.save
    else
      effect = Effect::ResourceEffect.create({
        bonus: self.bonus,
        character_id: character.id,
        resource_id: self.resource_id,
        type_id: Effect::ResourceEffect::RESOURCE_EFFECT_TYPE_SHOP,
        finished_at: Time.now + (self.duration * 3600), 
      })
        
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
