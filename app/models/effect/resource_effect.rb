class Effect::ResourceEffect < ActiveRecord::Base
  
  has_one    :event,     :class_name => "Event::Event", :foreign_key => "local_event_id",  :dependent => :destroy, :conditions => "event_type = 'resource_effect'"
  belongs_to :resource_pool, :class_name => "Fundamental::ResourcePool", :foreign_key => "resource_pool_id", :inverse_of => :resource_effects

  RESOURCE_EFFECT_TYPE_SHOP = 0
  RESOURCE_EFFECT_TYPE_ARTIFACT = 1

  after_create   :propagate_effect_creation
  before_destroy :propagate_effect_removal

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
