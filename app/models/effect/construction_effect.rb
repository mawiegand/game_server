class Effect::ConstructionEffect < ActiveRecord::Base
  

    has_one    :event,     :class_name => "Event::Event", :foreign_key => "local_event_id",  :dependent => :destroy, :conditions => "event_type = 'construction_effect'"
    belongs_to :character, :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :construction_effects

    CONSTRUCTION_EFFECT_TYPE_SHOP     = 0
    CONSTRUCTION_EFFECT_TYPE_ARTIFACT = 1

    after_create   :propagate_effect_creation
    before_destroy :propagate_effect_removal

    def self.create_or_extend_shop_effect(character, resource_id, bonus, duration)
      # check if same effects is already active
      effects = Effect::ResourceEffect.where(:resource_pool_id => character.resource_pool.id, 
                                             :type_id => Effect::ResourceEffect::RESOURCE_EFFECT_TYPE_SHOP, 
                                             :resource_id => resource_id)

      raise BadRequestError.new('more than one bonus active for same resource') if effects.count > 1

      effect = nil

      if effects.count == 1
        effect = effects.first
        effect.finished_at += duration * 3600
        effect.save

        event = effect.event
        raise BadRequestError.new('no event for existing effect') if event.nil?
        event.execute_at   += duration * 3600   # TODO: why not event.execute_at = effect.finished_at ???
        event.save
      else
        effect = Effect::ResourceEffect.create({
          bonus: bonus,
          resource_pool_id: character.resource_pool.id,
          resource_id: resource_id,
          type_id: Effect::ResourceEffect::RESOURCE_EFFECT_TYPE_SHOP,
          finished_at: Time.now + (duration * 3600),
        })

        # event for effect
        effect.create_event(
          character: character,
          execute_at: effect.finished_at,   # Ah, here it's used!
          event_type: "resource_effect",
          local_event_id: effect.id,
        )
      end

      effect
    end


    protected

      def propagate_effect_creation
        logger.debug "--------> propagate_effect_creation pool"
        self.resource_pool.add_effect_transaction(self)
      end

      def propagate_effect_removal
        logger.debug "--------> propagate_effect_removal pool"
        self.resource_pool.remove_effect_transaction(self)
      end

  
  
end
