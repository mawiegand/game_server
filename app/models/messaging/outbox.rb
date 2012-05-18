class Messaging::Outbox < ActiveRecord::Base
  
  belongs_to :owner, :class_name => "Fundamental::Character", :foreign_key => "owner_id", :inverse_of => :outbox  

  
end
