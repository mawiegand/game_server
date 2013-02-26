class Messaging::Archive < ActiveRecord::Base
  
  belongs_to :owner, :class_name => "Fundamental::Character",   :foreign_key => "owner_id",      :inverse_of => :archive
  has_many :entries, :class_name => "Messaging::ArchiveEntry",  :foreign_key => "archive_id",    :inverse_of => :archive, :order => :created_at, :dependent => :destroy

  attr_readable                                                                                           :as => :default
  attr_readable *readable_attributes(:default), :id, :owner_id, :messages_count, :created_at, :updated_at, :as => :owner
  attr_readable *readable_attributes(:owner),                                                             :as => :staff
  attr_readable *readable_attributes(:staff),                                                             :as => :admin
  
end
