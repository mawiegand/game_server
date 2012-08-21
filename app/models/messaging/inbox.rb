class Messaging::Inbox < ActiveRecord::Base

  belongs_to :owner,          :class_name => "Fundamental::Character", :foreign_key => "owner_id", :inverse_of => :inbox  
  has_many   :entries,        :class_name => "Messaging::InboxEntry",  :foreign_key => "inbox_id", :inverse_of => :inbox, :order => :created_at, :dependent => :destroy
  has_many   :unread_entries, :class_name => "Messaging::InboxEntry",  :foreign_key => "inbox_id", :inverse_of => :inbox, :order => :created_at, :dependent => :destroy, :conditions => { read: false }
  
  attr_readable                                                                                           :as => :default
  attr_readable *readable_attributes(:default), :id, :owner_id, :messages_count, :unread_messages_count, :created_at, :updated_at, :as => :owner
  attr_readable *readable_attributes(:owner),                                                             :as => :staff
  attr_readable *readable_attributes(:staff),                                                             :as => :admin

end
