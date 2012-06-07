class Messaging::Message < ActiveRecord::Base

  belongs_to :recipient, :class_name => "Fundamental::Character", :foreign_key => "recipient_id"
  belongs_to :sender,    :class_name => "Fundamental::Character", :foreign_key => "sender_id"

end
