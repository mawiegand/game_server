class Effect::ExperienceEffect < ActiveRecord::Base

  belongs_to :character, :class_name => "Fundamental::Character", :foreign_key => "character_id",    :inverse_of => :experience_effects

  EXPERIENCE_EFFECT_TYPE_START_GIFT = 0

  after_create   :propagate_effect_creation
  before_destroy :propagate_effect_removal

  protected

    def propagate_effect_creation
      self.character.add_experience_effect_transaction(self)
    end

    def propagate_effect_removal
      self.character.remove_experience_effect_transaction(self)
    end

end
