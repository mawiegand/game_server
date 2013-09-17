class Effect::AllianceExperienceEffect < ActiveRecord::Base

  belongs_to :alliance, :class_name => "Fundamental::Alliance", :foreign_key => "alliance_id", :inverse_of => :experience_effects

  EXPERIENCE_EFFECT_TYPE_START_GIFT = 0

  after_create   :propagate_effect_creation
  before_destroy :propagate_effect_removal

  protected

    def propagate_effect_creation
      self.alliance.add_experience_effect_transaction(self)
    end

    def propagate_effect_removal
      self.alliance.remove_experience_effect_transaction(self)
    end

end
