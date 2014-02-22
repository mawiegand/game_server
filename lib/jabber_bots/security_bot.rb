#encoding: utf-8

require 'xmpp4r'
require 'xmpp4r/muc'
require 'xmpp4r/muc/x/muc'
require 'xmpp4r/muc/iq/mucowner'
require 'xmpp4r/muc/iq/mucadmin'
require 'xmpp4r/muc/helper/mucbrowser'
require 'xmpp4r/dataforms'

require 'jabber_bots/runloop'

class JabberBots::SecurityBot

  def runloop
    @runloop
  end

  def runloop=(arg)
    @runloop = arg
  end

  def bot_type
    "security_bot"
  end

  def valid_user?(uid, nickname, domain)
    return false  if domain.nil? || GAME_SERVER_CONFIG['jabber']['host'] != domain.downcase
    return true   if nickname == GAME_SERVER_CONFIG['jabber']['name']
    return true   if nickname.starts_with? "WackyUser"    # most common reason are name changes...

    characters = Fundamental::Character.case_insensitive_identifier(uid)

    characters.each do |character|
      correct = character.name + (character.alliance.nil? ? "" : " | #{ character.alliance.tag }")
      return true if nickname == correct
    end

    false
  end

  def handle_new_presence(p)
    begin
      if p.x && p.x.kind_of?(Jabber::MUC::XMUCUser) && p.x.items && p.x.items.size > 0

        uid      = p.x.items[0].jid.node      # the character's unique id used to login as part of the JID
        nickname = p.from.resource            # the nickname set by the user (client)
        domain   = p.x.items[0].jid.domain    # the domain (host) of the JID

        unless valid_user?(uid, nickname, domain)
          Rails.logger.error "CHAT SECURITY: ERROR OR POSSIBLE BREACH: INVALID PRESENCE #{uid} on #{domain} as #{nickname}"
          runloop.say "POSSIBLE BREACH: INVALID PRESENCE #{uid} on #{domain} as #{nickname}"
          BotMailer.breach_report(uid, domain, nickname, p).deliver
        end
      else
        Rails.logger.error "CHAT SECURITY: ERROR: MISSING USER ITEM: #{p}"
        runloop.say "ERROR: MISSING USER ITEM: #{p.x}"
        BotMailer.missing_report(p).deliver
      end
    rescue => e
      Rails.logger.error  "CHAT SECURITY: ERROR: CATCHED EXCEPTION WHILE HANDLING PRESENCE #{e.message}, #{e.backtrace}."
      runloop.say  "EXCEPTION WHILE HANDLING PRESENCE #{e.message}, #{e.backtrace}."
      BotMailer.exception_report(p, e).deliver
    end
  end

  def init
    runloop.say "Security bot is connecting..."
    begin
      @client = Jabber::Client::new(Jabber::JID::new(GAME_SERVER_CONFIG['jabber']['bot_jid']))
      @client.connect
      @client.auth(GAME_SERVER_CONFIG['jabber']['password'])
      @client.send(Jabber::Presence.new.set_show(:away))

      public_room_jids = [
              "global@#{GAME_SERVER_CONFIG['jabber']['muc']}/Wächter | 5D",
        "plauderhöhle@#{GAME_SERVER_CONFIG['jabber']['muc']}/Wächter | 5D",
                "help@#{GAME_SERVER_CONFIG['jabber']['muc']}/Wächter | 5D",
              "handel@#{GAME_SERVER_CONFIG['jabber']['muc']}/Wächter | 5D",
      ]
      runloop.say "6"

      public_room_jids.each do |room|
        @muc_client = WatchGuard.new(@client, self)
        @muc_client.join(Jabber::JID.new(room))
      end
      runloop.say "Security bot is connected."
    rescue => e
      runloop.say "Security bot is crashed."
      runloop.say "CHAT SECURITY: error in security script #{e.message}, #{e.backtrace.inspect}"
      #puts "Error message: #{e.message}"
      #puts "Error backtrace: #{e.backtrace.inspect}"
    end
  end

  def process
    runloop.say "Security bot is running"
  end

  class BotMailer < ActionMailer::Base
    default from: Rails.env.production? ?  "watchguard@gs05.wack-a-doo.com" : "watchguard@test1.wack-a-doo.com"

    def breach_report(uid, domain, nickname, presence)
      mail(:to => GAME_SERVER_CONFIG['status_email_recipient'],
           :subject => "CHAT BOT: possible security breach by #{uid}.",
           :body => "#{uid}@#{domain} tried to access the chat as #{nickname}.\n\n#{presence}"
      )
    end

    def missing_report(presence)
      mail(:to => GAME_SERVER_CONFIG['status_email_recipient'],
           :subject => "CHAT BOT: missing user item.",
           :body => "Original Presence: #{presence}"
      )
    end

    def exception_report(presence, e)
      mail(:to => GAME_SERVER_CONFIG['status_email_recipient'],
           :subject => "CHAT BOT: exception.",
           :body => "Original Presence: #{presence}\nException #{e.message}, #{e.backtrace.inspect}"
      )
    end
  end

  class WatchGuard < Jabber::MUC::MUCClient
    def initialize(stream, callback_handler)
      super(stream)
      self.add_message_callback  { |m|  }
      self.add_presence_callback { |p| callback_handler.handle_new_presence(p) }
      self.add_join_callback     { |p| callback_handler.handle_new_presence(p) }
    end
  end
end



