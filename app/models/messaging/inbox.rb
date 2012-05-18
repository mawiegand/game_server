class Messaging::Inbox < ActiveRecord::Base

  belongs_to :owner, :class_name => "Fundamental::Character", :foreign_key => "owner_id", :inverse_of => :inbox  

  has_many :entries, :class_name => "Messaging::InboxEntry", :foreign_key => "inbox_id", :order => :created_at, :dependent => :destroy
  
end
