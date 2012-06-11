class Messaging::Outbox < ActiveRecord::Base
  
  belongs_to :owner, :class_name => "Fundamental::Character", :foreign_key => "owner_id", :inverse_of => :outbox  
  has_many :entries, :class_name => "Messaging::OutboxEntry",  :foreign_key => "outbox_id", :inverse_of => :outbox, :order => :created_at, :dependent => :destroy

  attr_readable                                                                                           :as => :default
  attr_readable *readable_attributes(:default), :id, :owner_id, :message_count, :created_at, :updated_at, :as => :owner
  attr_readable *readable_attributes(:owner),                                                             :as => :staff
  attr_readable *readable_attributes(:staff),                                                             :as => :admin
  
  
end
