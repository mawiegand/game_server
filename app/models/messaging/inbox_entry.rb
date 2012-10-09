class Messaging::InboxEntry < ActiveRecord::Base
  
  belongs_to :owner,   :class_name => "Fundamental::Character", :foreign_key => "owner_id" 
  belongs_to :sender,  :class_name => "Fundamental::Character", :foreign_key => "sender_id"
  belongs_to :inbox,   :class_name => "Messaging::Inbox",       :foreign_key => "inbox_id",   :inverse_of => :entries,         :counter_cache => :messages_count,        :touch => true 

  belongs_to :message, :class_name => "Messaging::Message",     :foreign_key => "message_id", :inverse_of => :inbox_entries
  
  attr_readable                                                                                                                                                                         :as => :default
  attr_readable *readable_attributes(:default), :id, :inbox_id, :read, :message_id, :owner_id, :sender_id, :subject, :updated_at, :created_at, :as => :owner
  attr_readable *readable_attributes(:owner),                                                                                                                                           :as => :staff
  attr_readable *readable_attributes(:staff),                                                                                                                                           :as => :admin
  
  after_save    :count_unread_messages   # this also handles entry creation
  after_destroy :decrement_unread_messages
  
  
  def count_unread_messages
    if self.read_changed? && self.read == true           # is true even on entry creation
      self.inbox.decrement(:unread_messages_count, 1)
      self.inbox.save
    elsif self.read_changed? && self.read.nil? || self.read == false 
      self.inbox.increment(:unread_messages_count, 1)
      self.inbox.save
    end
  end
  
  def decrement_unread_messages
    if self.read == false 
      self.inbox.decrement(:unread_messages_count, 1)
      self.inbox.save
    end
  end
  
end
