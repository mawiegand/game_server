class Shop::BonusOffer < ActiveRecord::Base

  def effect_for_character(character)
    effects = Effect::ResourceEffect.where(
      :resource_pool_id => character.resource_pool.id,
      :type_id => Effect::ResourceEffect::RESOURCE_EFFECT_TYPE_SHOP,
      :resource_id => self.resource_id,
      :origin_id => self.id
    )
    raise BadRequestError.new('more than one bonus active for same resource') if effects.count > 1

    if effects.empty?
      effects = Effect::ResourceEffect.where(
          :resource_pool_id => character.resource_pool.id,
          :type_id => Effect::ResourceEffect::RESOURCE_EFFECT_TYPE_SHOP,
          :resource_id => self.resource_id
      )
    end
    
    effects.first
  end
  
  def credit_to(character)
    Effect::ResourceEffect.create_or_extend_shop_effect(character, self.resource_id, self.bonus, self.duration, self.id)
  end
  
end
