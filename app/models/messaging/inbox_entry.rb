class Messaging::InboxEntry < ActiveRecord::Base
  
  belongs_to :owner,   :class_name => "Fundamental::Character", :foreign_key => "owner_id",  :inverse_of => :inbox_entries  
  belongs_to :sender,  :class_name => "Fundamental::Character", :foreign_key => "sender_id"
  belongs_to :inbox,   :class_name => "Messaging::Inbox",       :foreign_key => "inbox_id",  :inverse_of => :inbox_entries  

  has_one    :message, :class_name => "Messaging::Message",     :foreign_key => "message_id"
  
end
