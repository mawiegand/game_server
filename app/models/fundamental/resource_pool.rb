class Fundamental::ResourcePool < ActiveRecord::Base
  
  belongs_to :owner,    :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :resource_pool

end
