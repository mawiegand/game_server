class Effect::ResourceEffect < ActiveRecord::Base
  
  has_one    :event,     :class_name => "Event::Event", :foreign_key => "local_event_id",  :dependent => :destroy, :conditions => "event_type = 'resource_effect'"
  belongs_to :resource_pool, :class_name => "Fundamental::ResourcePool", :foreign_key => "resource_pool_id"  

  RESOURCE_EFFECT_TYPE_SHOP = 0

end
