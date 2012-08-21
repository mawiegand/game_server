class Messaging::InboxEntry < ActiveRecord::Base
  
  belongs_to :owner,   :class_name => "Fundamental::Character", :foreign_key => "owner_id",   :inverse_of => :inbox_entries  
  belongs_to :sender,  :class_name => "Fundamental::Character", :foreign_key => "sender_id"
  belongs_to :inbox,   :class_name => "Messaging::Inbox",       :foreign_key => "inbox_id",   :inverse_of => :entries,  :counter_cache => :messages_count, :touch => true 
  belongs_to :message, :class_name => "Messaging::Message",     :foreign_key => "message_id", :inverse_of => :inbox_entry
  
  attr_readable                                                                                                                                :as => :default
  attr_readable *readable_attributes(:default), :id, :inbox_id, :read, :message_id, :owner_id, :sender_id, :subject, :updated_at, :created_at, :as => :owner
  attr_readable *readable_attributes(:owner),                                                                                                  :as => :staff
  attr_readable *readable_attributes(:staff),                                                                                                  :as => :admin
  
end
