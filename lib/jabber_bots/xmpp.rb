#encoding: utf-8

module JabberBots
  class Xmpp

    def self.runloop
      @runloop
    end

    def self.connect(runloop)
      begin
        @runloop = runloop
        Jabber::debug = GAME_SERVER_CONFIG['jabber']['debug']
        @client = Jabber::Client::new(Jabber::JID::new(GAME_SERVER_CONFIG['jabber']['bot_jid']))
        @client.connect(GAME_SERVER_CONFIG['jabber']['server'])
        @client.auth(GAME_SERVER_CONFIG['jabber']['password'])
        @client.send(Jabber::Presence.new.set_show(:away))
        runloop.say "Verbindung zum JabberServer hergestellt"
      rescue Exception => e
        runloop.say "Fehler beim Verbinden zum Jabber Server"
        runloop.say "Error message: #{e.message}"
        runloop.say "Error backtrace: #{e.backtrace.inspect}"
        exit
      end
    end

    def self.close
      @client.close if @client
    end

    def self.muc_create(command)
      begin
        room_jid = Jabber::JID.new "#{ command.room }@#{GAME_SERVER_CONFIG['jabber']['muc']}/#{GAME_SERVER_CONFIG['jabber']['name']}"
        muc = Jabber::MUC::SimpleMUCClient.new(@client)
        muc.join(room_jid)

        if muc.owner?
          muc.say('Hi an alle. Dieser Raum wird nun Registriert')
          muc.configure(
            'muc#roomconfig_roomname'                => command.room , # Raumname
            'muc#roomconfig_roomdesc'                => command.room == "global" ? "WorldWide Chat" : "Raum des Stammes #{ command.room }", # Raum Beschreibung
            'muc#roomconfig_persistentroom'          => 1,    # Raum persistent machen
            'muc#roomconfig_publicroom'              => 0,    # Raum �ffentlich suchbar machen
            'muc#roomconfig_passwordprotectedroom'   => 0,    # Raum mit Passwort schuetzen
            'muc#roomconfig_roomsecret'              => '',   # Passwort
            'muc#roomconfig_maxusers'                => command.room == "global" ? 10000 : 1000,  # Maximale Anzahl von Teilnehmern
            'muc#roomconfig_whois'                   => "moderators", # Echte Jabber-IDs anzeigen f�r
            'muc#roomconfig_membersonly'             => 1,    # Raum nur f�r Mitglieder zug�nglich machen
            'muc#roomconfig_moderatedroom'           => 1,    # Raum moderiert machen
            'muc#roomconfig_changesubject'           => 1,    # Erlaube Benutzern das Thema zu �ndern
            'muc#roomconfig_allowinvites'            => 0,    # Erlaube Benutzern Einladungen zu senden
            'muc#roomconfig_allowvisitorstatus'      => 1,    # Erlaube Besuchern einen Text bei Status�nderung zu senden
            'muc#roomconfig_allowvisitornickchange'  => 0,    # Erlaube Besuchern ihren Spitznamen zu �ndern
            'muc#roomconfig_allowvoicerequests'      => 0,    # Anfragen von Sprachrechten f�r Benutzer erlauben
            'muc#roomconfig_voicerequestmininterval' => 1800, # Mindestdauer zwischen Anfragen f�r Sprachrechte (in Sekunden)
            'muc#roomconfig_captcha_whitelist'       => ''    # Vom CAPTCHA �berpr�fung ausgeschlossene Jabber IDs
          )
          muc.exit

          runloop.say "Raum #{command.room} hinzugefuegt"
        else
          runloop.say "Der Raum #{command.room} konnte nicht hinzugefuegt werden"
        end
      rescue Exception => e

        runloop.say "Der Raum #{command.room} konnte nicht hinzugefuegt werden"
        runloop.say "Error message: #{e.message}"
        runloop.say "Error backtrace: #{e.backtrace.inspect}"
      end
    end

    def self.muc_delete(command)
      begin
        room_jid = Jabber::JID.new "#{command.room}@#{GAME_SERVER_CONFIG['jabber']['muc']}/#{GAME_SERVER_CONFIG['jabber']['name']}"
        muc = Jabber::MUC::SimpleMUCClient.new(@client)
        muc.join(room_jid)

        if muc.owner?
          muc.say('Hi an alle. Dieser Raum wird nun geloescht.')

          #
          # TODO: Script zum l�schen des Raumes
          #
          iq = Jabber::Iq.new_query();
          iq.type = :set
          iq.to="#{name}@#{GAME_SERVER_CONFIG['jabber']['muc']}"
          iq.id = Jabber::IdGenerator.generate_id
          query = iq.query
          query.add_namespace('http://jabber.org/protocol/muc#owner')
          item = REXML::Element.new("destroy")
          item.add_attribute("jid", "#{command.room}@#{GAME_SERVER_CONFIG['jabber']['muc']}")
          query.add_element(item)
          stream = muc.instance_variable_get :@stream
          stream.send(iq)

          muc.exit

          runloop.say "Raum #{command.room} geloescht"
        else
          runloop.say "Fehlerhafte Berechtigung beim loeschen des Raumes #{command.room}"
        end
      rescue Exception => e
        runloop.say "Der Raum #{command.room} konnte nicht geloescht werden"
        runloop.say "Error message: #{e.message}"
        runloop.say "Error backtrace: #{e.backtrace.inspect}"
      end
    end

    def self.auth_add(command)
      begin
        room_jid = Jabber::JID.new "#{command.room}@#{GAME_SERVER_CONFIG['jabber']['muc']}/#{GAME_SERVER_CONFIG['jabber']['name']}"
        muc = Jabber::MUC::SimpleMUCClient.new(@client)
        muc.join(room_jid)

        if muc.owner?
          if command.room.starts_with? "plauderh"
            muc.say("Herzlich willkommen #{command.character.name}! :)")
          elsif command.room == "help" || command.room == "handel" || command.room == "global"
            # say nothing
          else
            muc.say("Ab sofort darf #{command.character.name} auch hier rein.")
          end

          useritem= Jabber::MUC::IqQueryMUCAdminItem.new()
          useritem.affiliation= :member
          useritem.jid = "#{command.data}@#{GAME_SERVER_CONFIG['jabber']['domain']}"

          runloop.say "JID: #{ useritem.jid }"
          muc.send_affiliations([useritem])  # wrap this in an array because the code in the gem xmpp / muc / helper / mucclient.rb is broken for non-arrays!!!!

          muc.exit

          runloop.say "Userrechte fuer #{command.character.name} bei Raum #{command.room} hinzugefuegt. jid: #{useritem.jid}."
        else
          runloop.say "Fehlerhafte Berechtigung beim Rechte hinzufuegen von #{command.character.name} im Raume #{command.room}."
        end
      rescue Exception => e
        runloop.say "Die Berechtigungen von #{command.character.name} konnten beim Raum #{command.room} nicht hinzugefuegt werden!"
        runloop.say "Error message: #{e.message}"
        runloop.say "Error backtrace: #{e.backtrace.inspect}"
      end
    end

    def self.auth_delete(command)
      begin
        room_jid = Jabber::JID.new "#{command.room}@#{GAME_SERVER_CONFIG['jabber']['muc']}/#{GAME_SERVER_CONFIG['jabber']['name']}"
        muc = Jabber::MUC::SimpleMUCClient.new(@client)
        muc.join(room_jid)

        if muc.owner?
          muc.say("Hi an alle. Ab sofort darf #{command.character.name} nun nicht mehr hier rein :(")

          useritem= Jabber::MUC::IqQueryMUCAdminItem.new()
          useritem.affiliation= :none
          useritem.jid = "#{command.data}@#{GAME_SERVER_CONFIG['jabber']['host']}"
          muc.send_affiliations([useritem])  # wrap this in an array because the code in the gem xmpp / muc / helper / mucclient.rb is broken for non-arrays!!!!
          muc.exit

          runloop.say "Userrechte fuer #{comamnd.character.name} bei Raum #{command.room} entfernt"
        else
          runloop.say "Fehlerhafte Berechtigung beim Rechte entfernen von #{command.character.name} im Raume #{command.room}"
        end
      rescue Exception => e
        runloop.say "Die Berechtigungen von #{command.character.name} konnten beim Raum #{command.room} nicht entfernt werden!"
        runloop.say "Error message: #{e.message}"
        runloop.say "Error backtrace: #{e.backtrace.inspect}"
      end
    end
  end
end