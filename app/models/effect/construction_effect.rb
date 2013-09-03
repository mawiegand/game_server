class Effect::ConstructionEffect < ActiveRecord::Base
  
  has_one    :event,     :class_name => "Event::Event",           :foreign_key => "local_event_id",  :dependent => :destroy, :conditions => "event_type = 'construction_effect'"
  belongs_to :character, :class_name => "Fundamental::Character", :foreign_key => "character_id",    :inverse_of => :construction_effects

  CONSTRUCTION_EFFECT_TYPE_SHOP     = 0
  CONSTRUCTION_EFFECT_TYPE_ARTIFACT = 1

  after_create   :propagate_effect_creation
  before_destroy :propagate_effect_removal

  def self.create_or_extend_shop_effect(character, bonus, duration)
    # check if same effects is already active
    effects = Effect::ConstructionEffect.where(:character_id => character.id, 
                                               :type_id => Effect::ConstructionEffect::CONSTRUCTION_EFFECT_TYPE_SHOP)

    raise BadRequestError.new('more than one shop bonus active for same character') if effects.count > 1

    effect = nil

    if effects.count == 1
      effect = effects.first
      effect.finished_at += duration * 3600
      effect.save

      event = effect.event
      raise BadRequestError.new('no event for existing effect') if event.nil?
      event.execute_at  = effect.finished_at
      event.save
    else
      effect = Effect::ConstructionEffect.create({
        bonus: bonus,
        character_id: character.id,
        type_id: Effect::ConstructionEffect::CONSTRUCTION_EFFECT_TYPE_SHOP,
        finished_at: Time.now + (duration * 3600),
      })

      # event for effect
      effect.create_event(
        character: character,
        execute_at: effect.finished_at,   # Ah, here it's used!
        event_type: "construction_effect",
        local_event_id: effect.id,
      )
    end

    effect
  end


  protected

    def propagate_effect_creation
      self.character.add_construction_effect_transaction(self)
    end

    def propagate_effect_removal
      self.character.remove_construction_effect_transaction(self)
    end

  
  
end
