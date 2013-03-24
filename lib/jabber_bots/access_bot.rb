require 'xmpp4r'
require 'xmpp4r/muc'
require 'xmpp4r/muc/helper/mucbrowser'

require 'jabber_bots/runloop'

class JabberBots::AccessBot
  
  def runloop 
    return @runloop
  end
  
  def runloop=(arg)
    @runloop = arg
  end
  
  def bot_type
    "access_bot"
  end
  
  def process
    runloop.say "Access bot process started"

    commands = Messaging::JabberCommand.where(processed: false, blocked_at: nil, command: 'muc_create').order(:created_at)
    if commands.count == 0
      commands = Messaging::JabberCommand.where('processed = ? AND blocked_at IS NULL', false).order(:created_at)
    end

    commands.each { |command| puts command.inspect }

    if commands.count > 0
      # Verbindung zum Jabber Server herstellen
      JabberBots::Xmpp.connect(runloop)

      commands.each do |command|
        command.blocked_at = Time.now
        command.blocked_by = "GAME SERVER ACCESS BOT"
        command.save
        case command.command
          when "muc_create"
            JabberBots::Xmpp.muc_create(command)
          when "muc_delete"
            JabberBots::Xmpp.muc_delete(command)
          when "auth_add"
            JabberBots::Xmpp.auth_add(command)
          when "auth_delete"
            JabberBots::Xmpp.auth_delete(command)
          else
            runloop.say "Unknown command: #{command.command}."
        end
        command.blocked_at = nil
        command.blocked_by = nil
        command.processed = true
        command.save
      end

      JabberBots::Xmpp.close
    end

    runloop.say "Access bot process completed"
  end
end

