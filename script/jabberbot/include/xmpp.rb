#encoding: utf-8

class Xmpp
  #
  def self.init
    file = File.open(APP_CONFIG['loggerPath'], File::WRONLY | File::APPEND | File::CREAT)
    file.sync = true
    @logger = Rails.logger || Logger.new(file)
    @logger.level = Logger::DEBUG
  end

  #
  def self.connect
    begin
      Jabber::debug = APP_CONFIG['jabber']['debug']
      @client = Jabber::Client::new(Jabber::JID::new(APP_CONFIG['jabber']['botJid']))
      @client.connect
      @client.auth(APP_CONFIG['jabber']['password'])
      @client.send(Jabber::Presence.new.set_show(:away))
      @logger.info "Verbindung zum JabberServer hergestellt"
    rescue Exception => e
      @logger.info "Fehler beim Verbinden zum Jabber Server"
      @logger.error "Error message: #{e.message}"
      @logger.error "Error backtrace: #{e.backtrace.inspect}"
      exit
    end
  end

  #
  def self.close
    @client.close if @client
  end

  #
  def self.message(text)
    message = Jabber::Message::new(APP_CONFIG['jabber']['adminJid'], "#{text}")
    message.set_type(:chat)
    @client.send message
  end

  #
  def self.muc_create(command)
    begin
      room_jid = Jabber::JID.new "#{ command.room }@#{APP_CONFIG['jabber']['muc']}/#{APP_CONFIG['jabber']['name']}"
      muc = Jabber::MUC::SimpleMUCClient.new(@client)
      muc.join(room_jid)

      if muc.owner?
        muc.say('Hi an alle. Dieser Raum wird nun Registriert')
        muc.configure(
          'muc#roomconfig_roomname'                => command.room , # Raumname
          'muc#roomconfig_roomdesc'                => command.room == "global" ? "WorldWide Chat" : "Raum des Stammes #{ command.room }", # Raum Beschreibung
          'muc#roomconfig_persistentroom'          => 1,    # Raum persistent machen
          'muc#roomconfig_publicroom'              => 0,    # Raum öffentlich suchbar machen
          'muc#roomconfig_passwordprotectedroom'   => 0,    # Raum mit Passwort schuetzen
          'muc#roomconfig_roomsecret'              => '',   # Passwort
          'muc#roomconfig_maxusers'                => 200,  # Maximale Anzahl von Teilnehmern
          'muc#roomconfig_whois'                   => "moderators", # Echte Jabber-IDs anzeigen für
          'muc#roomconfig_membersonly'             => 1,    # Raum nur für Mitglieder zugänglich machen
          'muc#roomconfig_moderatedroom'           => 1,    # Raum moderiert machen
          'muc#roomconfig_changesubject'           => 1,    # Erlaube Benutzern das Thema zu ändern
          'muc#roomconfig_allowinvites'            => 0,    # Erlaube Benutzern Einladungen zu senden
          'muc#roomconfig_allowvisitorstatus'      => 1,    # Erlaube Besuchern einen Text bei Statusänderung zu senden
          'muc#roomconfig_allowvisitornickchange'  => 0,    # Erlaube Besuchern ihren Spitznamen zu ändern
          'muc#roomconfig_allowvoicerequests'      => 0,    # Anfragen von Sprachrechten für Benutzer erlauben
          'muc#roomconfig_voicerequestmininterval' => 1800, # Mindestdauer zwischen Anfragen für Sprachrechte (in Sekunden)
          'muc#roomconfig_captcha_whitelist'       => ''    # Vom CAPTCHA Überprüfung ausgeschlossene Jabber IDs
        )
        muc.exit

        @logger.info "Raum #{command.room} hinzugefuegt"
      else
        @logger.error "Der Raum #{command.room} konnte nicht hinzugefuegt werden"
      end
    rescue Exception => e

      @logger.error "Der Raum #{command.room} konnte nicht hinzugefuegt werden"
      @logger.error "Error message: #{e.message}"
      @logger.error "Error backtrace: #{e.backtrace.inspect}"
    end
  end

  #
  def self.muc_delete(command)
    begin
      room_jid = Jabber::JID.new "#{command.room}@#{APP_CONFIG['jabber']['muc']}/#{APP_CONFIG['jabber']['name']}"
      muc = Jabber::MUC::SimpleMUCClient.new(@client)
      muc.join(room_jid)

      if muc.owner?
        muc.say('Hi an alle. Dieser Raum wird nun geloescht.')

        #
        # TODO: Script zum löschen des Raumes
        #
        iq = Jabber::Iq.new_query();
        iq.type = :set
        iq.to="#{name}@#{APP_CONFIG['jabber']['muc']}"
        iq.id = Jabber::IdGenerator.generate_id
        query = iq.query
        query.add_namespace('http://jabber.org/protocol/muc#owner')
        item = REXML::Element.new("destroy")
        item.add_attribute("jid", "#{command.room}@#{APP_CONFIG['jabber']['muc']}")
        query.add_element(item)
        stream = muc.instance_variable_get :@stream
        stream.send(iq)

        muc.exit

        @logger.info "Raum #{command.room} geloescht"
      else
        @logger.error "Fehlerhafte Berechtigung beim loeschen des Raumes #{command.room}"
      end
    rescue Exception => e
      @logger.error "Der Raum #{command.room} konnte nicht geloescht werden"
      @logger.error "Error message: #{e.message}"
      @logger.error "Error backtrace: #{e.backtrace.inspect}"
    end
  end

  #
  def self.auth_add(command)
    begin
      room_jid = Jabber::JID.new "#{command.room}@#{APP_CONFIG['jabber']['muc']}/#{APP_CONFIG['jabber']['name']}"
      muc = Jabber::MUC::SimpleMUCClient.new(@client)
      muc.join(room_jid)

      if muc.owner?
        muc.say("Hi an alle. Ab sofort darf #{command.character.name} nun auch hier rein :)")

        useritem= Jabber::MUC::IqQueryMUCAdminItem.new()
        useritem.affiliation= :member
        useritem.jid = "#{command.data}@#{APP_CONFIG['jabber']['host']}"

        @logger.error "JID: #{ useritem.jid }"
        muc.send_affiliations([useritem])  # wrap this in an array because the code in the gem xmpp / muc / helper / mucclient.rb is broken for non-arrays!!!!

        muc.exit

        @logger.info "Userrechte fuer #{command.character.name} bei Raum #{command.room} hinzugefuegt. jid: #{useritem.jid}."
      else
        @logger.info "Fehlerhafte Berechtigung beim Rechte hinzufuegen von #{command.character.name} im Raume #{command.room}. jid: #{useritem.jid}."
      end
    rescue Exception => e
      @logger.error "Die Berechtigungen von #{command.character.name} konnten beim Raum #{command.room} nicht hinzugefuegt werden!"
      @logger.error "Error message: #{e.message}"
      @logger.error "Error backtrace: #{e.backtrace.inspect}"
    end
  end

  #
  def self.auth_delete(command)
    begin
      room_jid = Jabber::JID.new "#{command.room}@#{APP_CONFIG['jabber']['muc']}/#{APP_CONFIG['jabber']['name']}"
      muc = Jabber::MUC::SimpleMUCClient.new(@client)
      muc.join(room_jid)

      if muc.owner?
        muc.say("Hi an alle. Ab sofort darf #{command.character.name} nun nicht mehr hier rein :(")

        useritem= Jabber::MUC::IqQueryMUCAdminItem.new()
        useritem.affiliation= :none
        useritem.jid = "#{command.data}@#{APP_CONFIG['jabber']['host']}"
        muc.send_affiliations([useritem])  # wrap this in an array because the code in the gem xmpp / muc / helper / mucclient.rb is broken for non-arrays!!!!


        muc.exit

        @logger.info "Userrechte fuer #{comamnd.character.name} bei Raum #{command.room} entfernt"
      else
        @logger.info "Fehlerhafte Berechtigung beim Rechte entfernen von #{command.character.name} im Raume #{command.room}"
      end
    rescue Exception => e
      @logger.error "Die Berechtigungen von #{command.character.name} konnten beim Raum #{command.room} nicht entfernt werden!"
      @logger.error "Error message: #{e.message}"
      @logger.error "Error backtrace: #{e.backtrace.inspect}"
    end
  end
end