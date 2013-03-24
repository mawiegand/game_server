require 'jabber_bots/patch'
require 'jabber_bots/xmpp'
require 'jabber_bots/access_bot'
require 'jabber_bots/security_bot'
require 'exception/http_exceptions'

module JabberBots

  def self.add_bot_class(bot_class)
    unless @bot_classes
      @bot_classes = []
    end
    @bot_classes.push bot_class
  end
  
  def self.bot_classes
    return @bot_classes
  end
  
  # register bots that should be used by the runloop
  JabberBots.add_bot_class(JabberBots::AccessBot)
  JabberBots.add_bot_class(JabberBots::SecurityBot) if Rails.env.production?

  class Runloop
    
    DEFAULT_SLEEP_DELAY     = 5

    cattr_accessor :sleep_delay, :logger

    def self.reset
      self.sleep_delay      = DEFAULT_SLEEP_DELAY
    end    
    
    reset 
    
    def bots
      unless @bots
        @bots = []
      end
      @bots
    end
    
    def register_jabber_bot(bot)
      bot.runloop = self
      bot.init if bot.respond_to?('init')
      bots << bot
      say "Registered jabber bot of type #{ bot.bot_type }."
    end
    
    def self.before_fork
      unless @files_to_reopen
        @files_to_reopen = []
        ObjectSpace.each_object(File) do |file|
          @files_to_reopen << file unless file.closed?
        end
      end
    end

    def self.after_fork
      # Re-open file handles
      @files_to_reopen.each do |file|
        begin
          file.reopen file.path, "a+"
          file.sync = true
        rescue ::Exception
        end
      end
          
      # reconnect to databse
      JabberBots::Runloop.logger.add Logger::INFO, "#{Time.now.strftime('%FT%T%z')}: Connection after fork: #{ActiveRecord::Base.connection.inspect}" if JabberBots::Runloop.logger
      ActiveRecord::Base.connection.reconnect!
      JabberBots::Runloop.logger.add Logger::INFO, "#{Time.now.strftime('%FT%T%z')}: Connection after reconnect: #{ActiveRecord::Base.connection.inspect}" if JabberBots::Runloop.logger
      JabberBots::Runloop.logger.add Logger::WARN, "#{Time.now.strftime('%FT%T%z')}: RECONNECT TO DATABASE FAILED." if JabberBots::Runloop.logger && !ActiveRecord::Base.connected?
    end
    
    def initialize(options={})
      @quiet = options.has_key?(:quiet) ? options[:quiet] : true
      self.class.sleep_delay  = options[:sleep_delay] if options.has_key?(:sleep_delay)
      JabberBots.bot_classes.each { |bot| self.register_jabber_bot(bot.new) }
    end

    # Every worker has a unique name which by default is the pid of the process. There are some
    # advantages to overriding this with something which survives worker restarts:  Workers can
    # safely resume working on tasks which are locked by themselves. The worker will assume that
    # it crashed before.
    def name
      return @name unless @name.nil?
      "#{@name_prefix}host:#{Socket.gethostname} pid:#{Process.pid}" rescue "#{@name_prefix}pid:#{Process.pid}"
    end

    # Sets the name of the worker.
    # Setting the name to nil will reset the default worker name
    def name=(val)
      @name = val
    end

    def start
      trap('TERM') { say 'Exiting...'; stop }
      trap('INT')  { say 'Exiting...'; stop }

      say "Starting jabber bot runloop"

      loop do
        break if @exit
        
        # bots durchgehen und process-Methode aufrufen
        bots.each do |bot|
          say "Starting processing bot of type #{bot.bot_type}."
          begin
            bot.process
          rescue SyntaxError, NameError => error
            say "CATCHED FATAL ERROR in jabber bot: #{bot}: #{ error.message }", Logger::ERROR
          rescue StandardError => error
            say "CATCHED ERROR in jabber bot: #{bot}: #{ error.message }", Logger::ERROR
          end
        end

        sleep(self.class.sleep_delay)
      end
    end

    def stop
      @exit = true
    end   
    
    def say(text, level = Logger::INFO)
      text = "[Worker(#{name})] #{text}"
      puts text unless @quiet
      logger.add level, "#{Time.now.strftime('%FT%T%z')}: #{text}" if logger
    end 
  end
end
