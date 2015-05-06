class Effect::ExperienceEffect < ActiveRecord::Base

  has_one    :event,     :class_name => "Event::Event",           :foreign_key => "local_event_id",  :dependent => :destroy, :conditions => "event_type = 'experience_effect'"
  belongs_to :character, :class_name => "Fundamental::Character", :foreign_key => "character_id",    :inverse_of => :experience_effects

  EXPERIENCE_EFFECT_TYPE_START_GIFT = 0
  EXPERIENCE_EFFECT_TYPE_STANDARD_ASSIGNMENT_REWARD = 4
  EXPERIENCE_EFFECT_TYPE_SPECIAL_ASSIGNMENT_REWARD = 5

  after_create   :propagate_effect_creation
  before_destroy :propagate_effect_removal

  def self.create_reward_effect(character, bonus, duration, origin_id, type_id)
    effect = Effect::ExperienceEffect.create({
        bonus: bonus,
        character_id: character.id,
        origin_id: origin_id,
        type_id: type_id,
        finished_at: Time.now + (duration * 3600),
    })

    # event for effect
    effect.create_event(
        character: character,
        execute_at: effect.finished_at,
        event_type: "experience_effect",
        local_event_id: effect.id,
    )

    !effect.nil?
  end

  protected

    def propagate_effect_creation
      self.character.add_experience_effect_transaction(self)
    end

    def propagate_effect_removal
      self.character.remove_experience_effect_transaction(self)
    end

end
