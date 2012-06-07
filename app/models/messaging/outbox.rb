class Messaging::Outbox < ActiveRecord::Base
  
  belongs_to :owner, :class_name => "Fundamental::Character", :foreign_key => "owner_id", :inverse_of => :outbox  
 
  has_many :entries, :class_name => "Messaging::OutboxEntry",  :foreign_key => "outbox_id", :inverse_of => :outbox, :order => :created_at, :dependent => :destroy

  
end
