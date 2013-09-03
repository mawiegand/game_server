class Effect::AllianceResourceEffect < ActiveRecord::Base

  belongs_to :alliance, :class_name => "Fundamental::Alliance", :foreign_key => "alliance_id", :inverse_of => :resource_effects

  RESOURCE_EFFECT_TYPE_ARTIFACT = 1

  after_create   :propagate_effect_creation
  before_destroy :propagate_effect_removal

  protected

  def propagate_effect_creation
    alliance.add_resource_effect_transaction(self)
  end

  def propagate_effect_removal
    alliance.remove_resource_effect_transaction(self)
  end

end
