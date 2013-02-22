class Messaging::ArchiveEntry < ActiveRecord::Base

  belongs_to :message,   :class_name => "Messaging::Message",     :foreign_key => "message_id",    :inverse_of => :archive_entries
  belongs_to :archive,   :class_name => "Messaging::Archive",     :foreign_key => "archive_id",    :inverse_of => :entries,     :counter_cache => :messages_count, :touch => true
  belongs_to :owner,     :class_name => "Fundamental::Character", :foreign_key => "owner_id"
  
  attr_readable                                                                                                                             :as => :default
  attr_readable *readable_attributes(:default), :id, :archive_id, :message_id, :sender_id, :owner_id, :type_id, :recipient_id, :subject, :updated_at, :created_at, :as => :owner
  attr_readable *readable_attributes(:owner),                                                                                               :as => :staff
  attr_readable *readable_attributes(:staff),                                                                                               :as => :admin

  ENTRY_TYPE_SENT     = 0
  ENTRY_TYPE_RECEIVED = 1

end
