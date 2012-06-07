class Messaging::OutboxEntry < ActiveRecord::Base

  belongs_to :outbox,   :class_name => "Messaging::Outbox",       :foreign_key => "outbox_id",   :inverse_of => :entries,  :counter_cache => :messages_count, :touch => true 
  
end
