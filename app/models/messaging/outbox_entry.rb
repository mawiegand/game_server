class Messaging::OutboxEntry < ActiveRecord::Base

  belongs_to :outbox,    :class_name => "Messaging::Outbox",      :foreign_key => "outbox_id",  :inverse_of => :entries,     :counter_cache => :messages_count, :touch => true   
  belongs_to :owner,     :class_name => "Fundamental::Character", :foreign_key => "owner_id"
  belongs_to :recipient, :class_name => "Fundamental::Character", :foreign_key => "recipient_id"
  belongs_to :message,   :class_name => "Messaging::Message",     :foreign_key => "message_id", :inverse_of => :inbox_entry
  
  attr_readable                                                                                                                             :as => :default
  attr_readable *readable_attributes(:default), :id, :outbox_id, :message_id, :owner_id, :recipient_id, :subject, :updated_at, :created_at, :as => :owner
  attr_readable *readable_attributes(:owner),                                                                                               :as => :staff
  attr_readable *readable_attributes(:staff),                                                                                               :as => :admin
  
end
