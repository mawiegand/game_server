class Messaging::ArchiveEntry < ActiveRecord::Base

  belongs_to :message, :class_name => "Messaging::Message",     :foreign_key => "message_id", :inverse_of => :archive_entries  
  
end
