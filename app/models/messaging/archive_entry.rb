class Messaging::ArchiveEntry < ActiveRecord::Base

  belongs_to :message, :class_name => "Messaging::Message",     :foreign_key => "message_id", :inverse_of => :archive_entries  
  belongs_to :archive,    :class_name => "Messaging::Archive",      :foreign_key => "archivebox_id",  :inverse_of => :entries,     :counter_cache => :messages_count, :touch => true   
  belongs_to :owner,     :class_name => "Fundamental::Character", :foreign_key => "owner_id",   :inverse_of => :archive_entries  
  
  attr_readable                                                                                                                             :as => :default
  attr_readable *readable_attributes(:default), :id, :archivebox_id, :message_id, :owner_id, :recipient_id, :subject, :updated_at, :created_at, :as => :owner
  attr_readable *readable_attributes(:owner),                                                                                               :as => :staff
  attr_readable *readable_attributes(:staff),                                                                                               :as => :admin
  
end
