class Effect::ResourceEffect < ActiveRecord::Base
  
  has_one    :event,     :class_name => "Event::Event", :foreign_key => "local_event_id",  :dependent => :destroy, :conditions => "event_type = 'resource_effect'"
  belongs_to :resource_pool, :class_name => "Fundamental::ResourcePool", :foreign_key => "resource_pool_id", :inverse_of => :resource_effects
  belongs_to :bonus_offer,   :class_name => "Shop::BonusOffer",          :foreign_key => "origin_id"

  RESOURCE_EFFECT_TYPE_SHOP = 0
  RESOURCE_EFFECT_TYPE_ARTIFACT = 1

  after_create   :propagate_effect_creation
  before_destroy :propagate_effect_removal
  
  
  def self.create_or_extend_shop_effect(character, resource_id, bonus, duration, origin_id)
    # check if same effects is already active
    effects = Effect::ResourceEffect.where(
      :resource_pool_id => character.resource_pool.id,
      :type_id => Effect::ResourceEffect::RESOURCE_EFFECT_TYPE_SHOP,
      :resource_id => resource_id,
      :origin_id => origin_id
    )
    
    raise BadRequestError.new('more than one bonus active for same resource') if effects.count > 1
    
    if effects.count == 1
      effect = effects.first
      effect.finished_at += duration * 3600
      effect.save
      
      event = effect.event
      raise BadRequestError.new('no event for existing effect') if event.nil?
      event.execute_at   += duration * 3600
      event.save
    else
      effect = Effect::ResourceEffect.create({
        bonus: bonus,
        resource_pool_id: character.resource_pool.id,
        resource_id: resource_id,
        origin_id: origin_id,
        type_id: Effect::ResourceEffect::RESOURCE_EFFECT_TYPE_SHOP,
        finished_at: Time.now + (duration * 3600),
      })
        
      # event for effect
      effect.create_event(
        character: character,
        execute_at: effect.finished_at,
        event_type: "resource_effect",
        local_event_id: effect.id,
      )
    end
    
    effect
  end
  

  protected

    def propagate_effect_creation
      self.resource_pool.add_resource_effect_transaction(self)
    end

    def propagate_effect_removal
      self.resource_pool.remove_resource_effect_transaction(self)
    end

end
