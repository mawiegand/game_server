require 'npc_ai/movement_handler'
require 'exception/http_exceptions'

module NpcAi

  def self.add_handler_class(handlerClass)
    unless @handler_classes 
      @handler_classes = []
    end
    @handler_classes.push handlerClass
  end
  
  def self.handler_classes
    return @handler_classes
  end
  
  # register handlers that should be used by the runloop
  NpcAi.add_handler_class(NpcAi::MovementHandler);

  class Runloop
    
    DEFAULT_SLEEP_DELAY     = 30    # -> Run Twice A Minute 

    cattr_accessor :sleep_delay, :logger

    def self.reset
      self.sleep_delay      = DEFAULT_SLEEP_DELAY
    end    
    
    reset 
    
    def handlers
      unless @handlers 
        @handlers = []
      end
      @handlers
    end
    
    def register_notification_handler(handler)
      handler.runloop = self
      handlers << handler
      say "Registered handler NPC AI of type #{ handler.notification_type }."
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
      NpcAi::Runloop.logger.add Logger::INFO, "#{Time.now.strftime('%FT%T%z')}: Connection after fork: #{ActiveRecord::Base.connection.inspect}" if NpcAi::Runloop.logger
      ActiveRecord::Base.connection.reconnect!     
      NpcAi::Runloop.logger.add Logger::INFO, "#{Time.now.strftime('%FT%T%z')}: Connection after reconnect: #{ActiveRecord::Base.connection.inspect}" if NpcAi::Runloop.logger
      NpcAi::Runloop.logger.add Logger::WARN, "#{Time.now.strftime('%FT%T%z')}: RECONNECT TO DATABASE FAILED." if NpcAi::Runloop.logger && !ActiveRecord::Base.connected?
    end
    
    def initialize(options={})
      @quiet = options.has_key?(:quiet) ? options[:quiet] : true
      self.class.sleep_delay  = options[:sleep_delay] if options.has_key?(:sleep_delay)
      NpcAi.handler_classes.each { |handler| self.register_notification_handler(handler.new) }
    end

    # Every worker has a unique name which by default is the pid of the process. There are some
    # advantages to overriding this with something which survives worker retarts:  Workers can#
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

      say "Starting NPC AI runloop"

      loop do
        break if @exit
        
        # handler durchgehen und process-Methode aufrufen
        handlers.each do |handler| 
          say "Starting processing AI handler of type #{handler.notification_type}."
          begin
            handler.process
          rescue SyntaxError, NameError => error
            say "CATCHED FATAL ERROR in NPC AI handler: #{handler}: #{ error.message }", Logger::ERROR
          rescue StandardError => error
            say "CATCHED ERROR in NPC AI handler: #{handler}: #{ error.message }", Logger::ERROR
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
