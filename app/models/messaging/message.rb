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
  OVERRUN_WINNER_REPORT_TYPE_ID = 5
  OVERRUN_LOSER_REPORT_TYPE_ID = 6
  FORTESS_WON_REPORT_TYPE_ID = 7
  FORTESS_LOST_REPORT_TYPE_ID = 8
  WELCOME_MESSAGE_TYPE_ID = 9

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
  
  def self.create_welcome_message(character)
    message = Messaging::Message.create({
      recipient: character,
      type_id:   WELCOME_MESSAGE_TYPE_ID,
      subject:   I18n.translate('application.messaging.welcome_message.subject'),
      body:      I18n.translate('application.messaging.welcome_message.body'),
      send_at:   DateTime.now,
      reported:  false,
      flag:      0,
    })
  end
  
  def self.generate_overrun_winner_message(winner, loser)
    # @army = army
    
    message = Messaging::Message.new({
      recipient: winner.owner,
      type_id:   OVERRUN_WINNER_REPORT_TYPE_ID,
      send_at:   DateTime.now,
      reported:  false,
      flag:      0,
    })
    
    message.add_overrun_winner_message_subject(winner, loser)
    message.add_overrun_winner_message_body(winner, loser)
    message.save
  end
    
  def add_overrun_winner_message_subject(winner, loser)
    self.subject = "Overrun army at " +  (winner.location.settlement.nil? ? winner.region.name.to_s : winner.location.settlement.name.to_s) 
  end
  
  def add_overrun_winner_message_body(winner, loser)
    text  = "<h2>Your army has overrun another army at " + (winner.location.settlement.nil? ? winner.region.name.to_s : winner.location.settlement.name.to_s) + "</h2>\n"
    text += "<p>Your army <b>" + winner.name.to_s + "</b> positioned at <b>" + (loser.location.settlement.nil? ? loser.region.name.to_s : loser.location.settlement.name.to_s) 
    text += "</b> has overrun the army <b>" + loser.name.to_s + "</b> of <b>" + loser.owner_name_and_ally_tag + "</b>.</p>\n"
    text += "<table>\n"
    text += "<tr>\n"
    text += "<th>Army Name</th><th>Owner</th><th>Size</th>\n"
    text += "</tr>\n"
    text += "<tr>\n"
    text += "<td>" + loser.name.to_s + "</td><td>" + loser.owner_name_and_ally_tag + "</td><td>" + loser.strength.to_s + "</td>\n"
    text += "</tr>\n"
    text += "<tr>\n"
    text += "<td>" + winner.name.to_s + "</td><td>" + winner.owner_name_and_ally_tag + "</td><td>" + winner.strength.to_s + "</td>\n"
    text += "</tr>\n"
    text += "</table>\n"
    text += "<p>None of your opponents units survived, your army didn't suffer any loss.</p>\n"
    self.body = text
  end

  def self.generate_overrun_loser_message(winner, loser)
    message = Messaging::Message.new({
      recipient: loser.owner,
      type_id:   OVERRUN_LOSER_REPORT_TYPE_ID,
      send_at:   DateTime.now,
      reported:  false,
      flag:      0,
    })
    
    message.add_overrun_loser_message_subject(winner, loser)
    message.add_overrun_loser_message_body(winner, loser)
    message.save
  end
  
  def add_overrun_loser_message_subject(winner, loser)
    self.subject = "Overrun army at " +  (loser.location.settlement.nil? ? loser.region.name.to_s : loser.location.settlement.name.to_s) 
  end
  
  def add_overrun_loser_message_body(winner, loser)
    text  = "<h2>Your army has been overrun at " + (winner.location.settlement.nil? ? winner.region.name.to_s : winner.location.settlement.name.to_s)  + "</h2>\n"
    text += "<p>Your army <b>" + loser.name.to_s + "</b> positioned at location <b>" + (loser.location.settlement.nil? ? loser.region.name.to_s : loser.location.settlement.name.to_s) 
    text += "</b> has been overrun by the army <b>" + winner.name.to_s + "</b> of <b>" + winner.owner_name_and_ally_tag + "</b>.</p>\n"
    text += "<table>\n"
    text += "<tr>\n"
    text += "<th>Army Name</th><th>Owner</th><th>Size</th>\n"
    text += "</tr>\n"
    text += "<tr>\n"
    text += "<td>" + winner.name.to_s + "</td><td>" + winner.owner_name_and_ally_tag + "</td><td>" + winner.strength.to_s + "</td>\n"
    text += "</tr>\n"
    text += "<tr>\n"
    text += "<td>" + loser.name.to_s + "</td><td>" + loser.owner_name_and_ally_tag + "</td><td>" + loser.strength.to_s + "</td>\n"
    text += "</tr>\n"
    text += "</table>\n"
    text += "<p>None of your units survived, your army is lost irretrievably.</p>\n"
    self.body = text
  end
  
  def self.generate_gained_fortress_message(settlement, old_owner, new_owner)
    message = Messaging::Message.new({
      recipient: new_owner,
      type_id:   FORTESS_WON_REPORT_TYPE_ID,
      send_at:   DateTime.now,
      reported:  false,
      flag:      0,
    })
    
    message.add_gained_fortress_message_subject(settlement, old_owner, new_owner)
    message.add_gained_fortress_message_body(settlement, old_owner, new_owner)
    message.save
  end
  
  def add_gained_fortress_message_subject(settlement, old_owner, new_owner)
    self.subject = "Won fortress of " + settlement.region.name.to_s 
  end
  
  def add_gained_fortress_message_body(settlement, old_owner, new_owner)
    text  = "<h2>You won the fortress at " + settlement.region.name.to_s + "</h2>\n"
    text += "<p>Your army at region <b>" + settlement.region.name.to_s + "</b> won the battle for fortress <b>" + settlement.name.to_s + "</b>.</p>\n" 
    self.body = text
  end
  
  def self.generate_lost_fortress_message(settlement, old_owner, new_owner)
    message = Messaging::Message.new({
      recipient: old_owner,
      # message.sender_id = nil
      type_id:   FORTESS_LOST_REPORT_TYPE_ID,
      send_at:   DateTime.now,
      reported:  false,
      flag:      0,
    })
    
    message.add_lost_fortress_message_subject(settlement, old_owner, new_owner)
    message.add_lost_fortress_message_body(settlement, old_owner, new_owner)
    message.save
  end
  
  def add_lost_fortress_message_subject(settlement, old_owner, new_owner)
    self.subject = "Lost fortress of " + settlement.region.name.to_s 
  end
  
  def add_lost_fortress_message_body(settlement, old_owner, new_owner)
    text  = "<h2>You lost your fortress at " + settlement.region.name.to_s + "</h2>\n"
    text += "<p>Your garrison army at region <b>" + settlement.region.name.to_s + "</b> has lost the battle for fortress <b>" + settlement.name.to_s + "</b>. " 
    text += "The new owner of the fortress is <b>" + new_owner.name_and_ally_tag + "</b>.</p>\n"
    self.body = text
  end
end
