# encoding: utf-8

# A message is send from a sender to a receiver. Messages with multiple 
# will be stores in as many copies in the system (To Be Reconsidered later)
class Messaging::Message < ActiveRecord::Base

  belongs_to :recipient,       :class_name => "Fundamental::Character",   :foreign_key => "recipient_id"
  belongs_to :sender,          :class_name => "Fundamental::Character",   :foreign_key => "sender_id"
  belongs_to :owner,           :class_name => "Fundamental::Character",   :foreign_key => "owner_id"

  has_many   :inbox_entries,   :class_name => "Messaging::InboxEntry",    :foreign_key => "message_id",  :dependent => :destroy,  :inverse_of => :message   # can be in one or no inbox
  has_many   :archive_entries, :class_name => "Messaging::ArchiveEntry",  :foreign_key => "message_id",  :dependent => :destroy,  :inverse_of => :message   # can be in one or no archive
  has_one    :outbox_entry,    :class_name => "Messaging::OutboxEntry",   :foreign_key => "message_id",  :dependent => :destroy,  :inverse_of => :message   # can be in one or no outbox 
  
  
  after_create :deliver_message

  # constants for the message.type_id
  USER_MESSAGE_TYPE_ID            = 0
  BATTLE_REPORT_TYPE_ID           = 1
  BATTLE_STARTED_TYPE_ID          = 2
  ARMY_LOST_TYPE_ID               = 3
  ARMY_RETREATED_TYPE_ID          = 4
  OVERRUN_WINNER_REPORT_TYPE_ID   = 5
  OVERRUN_LOSER_REPORT_TYPE_ID    = 6
  FORTESS_WON_REPORT_TYPE_ID      = 7
  FORTESS_LOST_REPORT_TYPE_ID     = 8
  WELCOME_MESSAGE_TYPE_ID         = 9
  TUTORIAL_MESSAGE_TYPE_ID        = 10
  TRADE_MESSAGE_TYPE_ID           = 11
  ANNOUNCEMENT_TYPE_ID            = 12
  ALLIANCE_TYPE_ID                = 13
  MESSAGE_TYPE_ARTIFACT_CAPTURED  = 14
  MESSAGE_TYPE_ARTIFACT_JUMPED    = 15
  MESSAGE_TYPE_ARTIFACT_STOLEN    = 16
  INDIVIDUAL_ANNOUNCEMENT_TYPE_ID = 17

  scope :system, where(type_id: ANNOUNCEMENT_TYPE_ID)

  # creates inbox and outbox entries for the message
  def deliver_message
    if self.type_id == ANNOUNCEMENT_TYPE_ID
      Fundamental::Character.non_banned.not_deleted.non_npc.each do |character|
        if !character.inbox.nil?
          character.inbox.entries.create({
            sender_id:  nil,
            owner_id:   character.id,
            message_id: self.id,
            subject:    self.subject,
          })
        else
          logger.error "ERROR: Could not deliver newsletter message #{ self.id } to character #{ character.id }. Failed to create an inbox entry."
        end
      end
    elsif self.type_id == ALLIANCE_TYPE_ID
      if !self.sender.nil? && !self.sender.alliance.nil?
        self.sender.alliance.members.each do |member| 
     #    if member != self.sender   # TODO : decide whether or not to deliver the message to self.
             member.inbox.entries.create({
               sender_id:  self.sender.id,
               owner_id:   member.id,
               message_id: self.id,
               subject:    self.subject,
             })
          end
    #     end
      else 
        logger.error "ERROR: Could not deliver alliance message #{ self.id } to recipients beacause sender is not in an alliance."
      end
    else # standard message
      unless self.recipient.nil?
        @character = Fundamental::Character.find(self.recipient_id)
        if !@character.nil? && !@character.inbox.nil?
          @character.inbox.entries.create({
            sender_id:  self.sender_id,
            owner_id:   @character.id,
            message_id: self.id,
            subject:    self.subject,
          })
        else
          logger.error "ERROR: Could not deliver message #{ self.id} to recipient. Failed to create an inbox entry."
        end
      end
    
      if !self.sender.nil? && self.type_id != INDIVIDUAL_ANNOUNCEMENT_TYPE_ID
        @character = Fundamental::Character.find(self.sender_id)
        if !@character.nil? && !@character.outbox.nil?
          @character.outbox.entries.create({
            recipient_id:  self.recipient_id,
            owner_id:      @character.id,
            message_id:    self.id,
            subject:       self.subject,
          })
        else
          logger.error "ERROR: Could not store message #{ self.id} in sender's outbox. Failed to create an outbox entry."
        end
      end    
    end
    
    true # need to return true, because otherwise the filter chain would break
  end

  def move_to_archive_of_character(character)
    entry = character.archive.entries.new({
      sender_id:     self.sender_id,
      recipient_id:  self.recipient_id,
      owner_id:      character.id,
      message_id:    self.id,
      subject:       self.subject,
      created_at:    self.created_at,
    })

    if self.sender == character
      entry.type_id = Messaging::ArchiveEntry::ENTRY_TYPE_SENT
      entry.save
      character.outbox.entries.where(:message_id => self.id).destroy_all
    elsif self.recipient == character
      entry.type_id = Messaging::ArchiveEntry::ENTRY_TYPE_RECEIVED
      entry.save
      character.inbox.entries.where(:message_id => self.id).destroy_all
    end
  end

  def notify_offline_recipients
    if self.type_id == ANNOUNCEMENT_TYPE_ID || self.type_id == ALLIANCE_TYPE_ID
      self.inbox_entries.each do |inbox_entry|
        if !inbox_entry.owner.nil? && inbox_entry.owner.offline?
          
          ip_access = IdentityProvider::Access.new(
            identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
            game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
            scopes:                     ['5dentity'],
          )
          ip_access.deliver_message_notification(inbox_entry.owner, self.sender, self)      
          
        end
      end  
    else
      # TODO : move implementation from messaging_messages controller to here.
    end
  end

  ## specialized messages ####################################

  def self.create_welcome_message(character)
    Messaging::Message.create({
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

  def self.generate_battle_report_message(recipient, subject, body)
    message = Messaging::Message.new({
      recipient: recipient,
      type_id:   BATTLE_REPORT_TYPE_ID,
      subject:   subject,
      body:      body,
      send_at:   DateTime.now,
      reported:  false,
    })
    message.save
  end  

  def self.generate_trade_recipient_message(action)
    return if action.nil?
    message = Messaging::Message.new({
      recipient_id: action.recipient_id,
      type_id:   TRADE_MESSAGE_TYPE_ID,
      send_at:   DateTime.now,
    })

    text = "<h2>Lieferung aus #{action.starting_settlement.name}.</h2>"
    text += "<p>#{action.num_carts} Handelskarren aus #{ action.starting_settlement.name } (#{action.starting_settlement.owner.name}) #{ (action.num_carts == 1 ? 'ist' : 'sind') } soeben angekommen. Es wurde folgendes ausgeladen:</p>"
    text += "<p>" + Messaging::Message.resource_amounts_to_html(action, false) + "</p>"
    message.subject = "Lieferung aus #{action.starting_settlement.name}."
    message.body = text
    
    message
  end

  def self.generate_trade_sender_message(action)
    return if action.nil?
    message = Messaging::Message.new({
      recipient_id: action.sender_id,
      type_id:   TRADE_MESSAGE_TYPE_ID,
      send_at:   DateTime.now,
    })

    text = "<h2>Ankunft von #{action.num_carts == 1 ? "einem" : action.num_carts} Handelskarren in #{action.target_settlement.name}.</h2>"
    text += "<p>Deine Handelskarren sind soeben an ihrem Ziel #{ action.target_settlement.name } (#{action.target_settlement.owner.name}) angekommen. Es wurde folgendes vor Ort ausgeladen:</p>"
    text += "<p>" + Messaging::Message.resource_amounts_to_html(action, false) + "</p>"
    message.subject = "Ankunft von #{action.num_carts} Handelskarren"
    message.body = text
    
    message
  end
  
  def self.generate_trade_return_message(action)
    return if action.nil?
    message = Messaging::Message.new({
      recipient_id: action.sender_id,
      type_id:   TRADE_MESSAGE_TYPE_ID,
      send_at:   DateTime.now,
    })

    text = "<h2>Rückkehr von #{action.num_carts == 1 ? "einem" : action.num_carts} " + (action.empty? ? "leeren" : " beladenen ") + " Handelskarren nach #{action.starting_settlement.name}.</h2>"
    if action.empty?
      text += "<p>Deine Handelskarren sind leer von ihrer Reise nach #{ action.target_settlement.name } (#{action.target_settlement.owner.name}) zurück gekommen.</p>"
    else 
      text += "<p>Deine Handelskarren sind von ihrer Reise nach #{ action.target_settlement.name } (#{action.target_settlement.owner.name}) zurück gekommen. Sie brachten folgende Ladung mit:</p>"
      text += "<p>" + Messaging::Message.resource_amounts_to_html(action, false) + "</p>"
    end
    message.subject = "Rückkehr von #{action.num_carts == 1 ? "einem" : action.num_carts} " + (action.empty? ? "leeren" : "beladenen") + " Handelskarren"
    message.body = text
    
    message
  end

  def self.resource_amounts_to_html(amounts, include_all=true, spacer="<br/>")
    text = ""
    GameRules::Rules.the_rules().resource_types.each do |resource_type|
      field_name = resource_type[:symbolic_id].to_s() + '_amount'
      if !amounts[field_name].blank? && (include_all || amounts[field_name] != 0)
        text += "<span class=\"resource-icon #{ resource_type[:symbolic_id].to_s }\"  title=\"#{ resource_type[:name][:de_DE] }\">&nbsp;</span> #{ amounts[field_name] || 0 }#{spacer}"
      end
    end   
    text     
  end
    
  def add_overrun_winner_message_subject(winner, loser)
    self.subject = "Du hast die Armee an der Siedlung " +  (winner.location.settlement.nil? ? winner.region.name.to_s : winner.location.settlement.name.to_s) + " überrannt" 
  end
  
  def add_overrun_winner_message_body(winner, loser)
    text  = "<h2>Deine Armee hat eine andere Armee an der Siedlung " + (winner.location.settlement.nil? ? winner.region.name.to_s : winner.location.settlement.name.to_s) + " überrannt</h2>\n"
    text += "<p>Deine Armee <b>" + winner.name.to_s + "</b>, stationiert an der Siedlung <b>" + (loser.location.settlement.nil? ? loser.region.name.to_s : loser.location.settlement.name.to_s) 
    text += "</b>, hat die Armee <b>" + loser.name.to_s + "</b> von <b>" + loser.owner_name_and_ally_tag + "</b> überrannt.</p>\n"
    text += "<table>\n"
    text += "<tr>\n"
    text += "<th>Armeename</th><th>Besitzer</th><th>Größe</th>\n"
    text += "</tr>\n"
    text += "<tr>\n"
    text += "<td>" + loser.name.to_s + "</td><td>" + loser.owner_name_and_ally_tag + "</td><td>" + loser.size_present.to_s + "</td>\n"
    text += "</tr>\n"
    text += "<tr>\n"
    text += "<td>" + winner.name.to_s + "</td><td>" + winner.owner_name_and_ally_tag + "</td><td>" + winner.size_present.to_s + "</td>\n"
    text += "</tr>\n"
    text += "</table>\n"
    text += "<p>Deine Einheiten haben alle überlebt, Dein Gegner hat alle Einheiten verloren. Für diesen Sieg erlangst Du keine Erfahrung.</p>\n"
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
    self.subject = "Deine Armee ist überrant worden an " +  (loser.location.settlement.nil? ? loser.region.name.to_s : loser.location.settlement.name.to_s) 
  end
  
  def add_overrun_loser_message_body(winner, loser)
    text  = "<h2>Deine Armee ist überrannt worden in " + (winner.location.settlement.nil? ? winner.region.name.to_s : winner.location.settlement.name.to_s)  + "</h2>\n"
    text += "<p>Deine Armee <b>" + loser.name.to_s + "</b> ist in der Region <b>" + (loser.location.settlement.nil? ? loser.region.name.to_s : loser.location.settlement.name.to_s) 
    text += "</b>ist von einer Armee von<b>" + winner.name.to_s + "</b> von<b>" + winner.owner_name_and_ally_tag + "</b>.</p>\n"
    text += "<table>\n"
    text += "<tr>\n"
    text += "<th>Army Name</th><th>Besitzer</th><th>Size</th>\n"
    text += "</tr>\n"
    text += "<tr>\n"
    text += "<td>" + winner.name.to_s + "</td><td>" + winner.owner_name_and_ally_tag + "</td><td> ? </td>\n"
    text += "</tr>\n"
    text += "<tr>\n"
    text += "<td>" + loser.name.to_s + "</td><td>" + loser.owner_name_and_ally_tag + "</td><td>" + loser.size_present.to_s + "</td>\n"
    text += "</tr>\n"
    text += "</table>\n"
    text += "<p>Keine Deiner Einheiten hat überlebt, Deine Armee ist engültig verloren.</p>\n"
    self.body = text
  end
  
  def self.generate_kicked_from_alliance_message(character, kicking_character)
    message = Messaging::Message.new({
      recipient: character,
      type_id:   ALLIANCE_TYPE_ID,
      send_at:   DateTime.now,
    })
    message.subject = "Rauswurf"
    message.body    = "<p>Du wurdest soeben von #{kicking_character.name} aus der Allianz #{kicking_character.alliance.name} geworfen.</p>"
    message.save
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
    self.subject = "Siedlung gewonnen von " + settlement.region.name.to_s
  end

  def add_gained_fortress_message_body(settlement, old_owner, new_owner)
    text  = "<h2>Du hast die Siedlung in " + settlement.region.name.to_s + " erobert.</h2>\n"
    text += "<p>Juhu! Deine Armeen haben den Kampf in der Region <b>" + settlement.region.name.to_s + "</b> um die Siedlung <b>" + settlement.name.to_s + "</b> gewonnen. Du bist jetzt neuer Besitzer der Siedlung.</p>\n"
    self.body = text
  end

  def self.generate_artifact_captured_message(character)
    message = Messaging::Message.new({
      recipient: character,
      type_id:   MESSAGE_TYPE_ARTIFACT_CAPTURED,
      send_at:   DateTime.now,
      reported:  false,
      flag:      0,
    })
    message.subject = "Du hast ein Artefakt gewonnen!"
    message.body = "<p>Hurra! Unsere Armeen haben erfolgreich gekämpft und von unserem Gegner ein Artefakt erobert. Du kannst das Artefakt in Deiner Hauptsiedlung bewundern. Für die Aktivierung musst Du einen Artefakt-Stand bauen.</p>\n"
    message.save
  end

  def self.generate_artifact_jumped_message(character)
    message = Messaging::Message.new({
      recipient: character,
      type_id:   MESSAGE_TYPE_ARTIFACT_JUMPED,
      send_at:   DateTime.now,
      reported:  false,
      flag:      0,
    })
    message.subject = "Das Artefakt ist verloren!"
    message.body = "<p>So ein Mist! Unsere Armeen haben zwar erfolgreich gekämpft, aber das Artefakt ging während des Kampfes verloren. Suche das verlorene Artefakt bei einer Neandertaler-Armee in der Nähe.</p>\n"
    message.save
  end

  def self.generate_artifact_stolen_message(character)
    message = Messaging::Message.new({
      recipient: character,
      type_id:   MESSAGE_TYPE_ARTIFACT_STOLEN,
      send_at:   DateTime.now,
      reported:  false,
      flag:      0,
    })
    message.subject = "Dein Artefakt wurde geraubt!"
    message.body = "<p>Och menno! Deine Untergebenen haben tapfer gekämpft, aber das Artefakt wurde Dir geraubt. Einheiten rekrutieren, Armeen aufstellen und dann wird sich das Artefakt zurückgeholt! Ein anderes tut es aber auch.</p>\n"
    message.save
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
    self.subject = "Siedlung verloren an " + settlement.region.name.to_s
  end

  def add_lost_fortress_message_body(settlement, old_owner, new_owner)
    text  = "<h2>Du hast Deine Siedlung in der Region " + settlement.region.name.to_s + " verloren </h2>\n"
    text += "<p>Deine Garnisonsarmee in Region <b>" + settlement.region.name.to_s + "</b> hat den Kampf um die Siedlung verloren.<b>" + settlement.name.to_s + "</b>. "
    text += "Der neue Besitzer der Siedlung ist <b>" + new_owner.name_and_ally_tag + "</b>.</p>\n"
    self.body = text
  end
  
  def self.create_tutorial_message(character, subject, boby)
    message = Messaging::Message.create({
      recipient: character,
      type_id:   TUTORIAL_MESSAGE_TYPE_ID,
      subject:   subject,
      body:      boby,
      send_at:   DateTime.now,
      reported:  false,
      flag:      0,
    })
  end
end
