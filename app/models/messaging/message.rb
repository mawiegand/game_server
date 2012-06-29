# A message is send from a sender to a receiver. Messages with multiple 
# will be stores in as many copies in the system (To Be Reconsidered later)
class Messaging::Message < ActiveRecord::Base

  belongs_to :recipient,      :class_name => "Fundamental::Character",   :foreign_key => "recipient_id"
  belongs_to :sender,         :class_name => "Fundamental::Character",   :foreign_key => "sender_id"
  
  has_one    :inbox_entry,    :class_name => "Messaging::InboxEntry",    :foreign_key => "message_id",  :inverse_of => :message   # can be in one or no inbox
  has_one    :archive_entry,  :class_name => "Messaging::ArchiveEntry",  :foreign_key => "message_id",  :inverse_of => :message   # can be in one or no archive
  has_one    :outbox_entry,   :class_name => "Messaging::OutboxEntry",   :foreign_key => "message_id",  :inverse_of => :message   # can be in one or no outbox 
  
  
  after_create :deliver_message

  # constants for the message.type_id
  USER_MESSAGE_TYPE_ID = 0
  BATTLE_REPORT_TYPE_ID = 1
  BATTLE_STARTED_TYPE_ID = 2
  ARMY_LOST_TYPE_ID = 3
  ARMY_RETREATED_TYPE_ID = 4

  # creates inbox and outbox entries for the message
  def deliver_message
    if !self.recipient_id.nil?
      @character = Fundamental::Character.find(self.recipient_id)
      if !@character.nil? && !@character.inbox.nil?
        @character.inbox.entries.create({
          sender_id:  self.sender_id,
          owner_id:   @character.id,
          message_id: self.id,
          subject:    self.subject,
        });
      else
        logger.error "Could not deliver message #{ self.id} to recipient. Failed to create an inbox entry."
      end
    end
    
    if !self.sender_id.nil?
      @character = Fundamental::Character.find(self.sender_id)
      if !@character.nil? && !@character.outbox.nil?
        @character.outbox.entries.create({
          recipient_id:  self.recipient_id,
          owner_id:      @character.id,
          message_id:    self.id,
          subject:       self.subject,
        });
      else
        logger.error "Could not store message #{ self.id} in sender's outbox. Failed to create an outbox entry."
      end
    end    
    
    return true # need to return true, because otherwise the filter chain would break
  end

  ## specialiced messages ####################################

  #creates a message that an Army
  def self.create_army_retreat_message(army)
    #message = "Your army "+army.
  end
  
end
