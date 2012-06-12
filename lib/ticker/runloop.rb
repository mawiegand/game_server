require 'ticker/movement_handler'
require 'ticker/battle_handler'
require 'ticker/construction_active_job_handler'
require 'ticker/construction_queue_check_handler'

module Ticker

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
  Ticker.add_handler_class(Ticker::MovementHandler);
  Ticker.add_handler_class(Ticker::BattleHandler);
  Ticker.add_handler_class(Ticker::ConstructionActiveJobHandler);
  Ticker.add_handler_class(Ticker::ConstructionQueueCheckHandler);

  class Runloop
    
    DEFAULT_SLEEP_DELAY      = 1

    cattr_accessor :sleep_delay, :logger

    def self.reset
      self.sleep_delay      = DEFAULT_SLEEP_DELAY
    end    
    
    reset 
    
    def handlers
      unless @handlers 
        @handlers = {}
      end
      @handlers
    end
    
    def register_event_handler(handler)
      handlers[handler.event_type] = handler
      handler.runloop = self
      say "Registered handler for events of type #{ handler.event_type }."
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
    end
    
    def initialize(options={})
      @quiet = options.has_key?(:quiet) ? options[:quiet] : true
      self.class.sleep_delay  = options[:sleep_delay] if options.has_key?(:sleep_delay)
      Ticker.handler_classes.each { |handler| self.register_event_handler(handler.new) }
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

      say "Starting ticker runloop"

      loop do
        break if @exit
        
        next_event = lock_next_event
        if !next_event
          sleep(self.class.sleep_delay)
        else 
          handler = handlers[next_event.event_type]
          if handler 
            handler.process_event next_event
          else
            say "No handler registered for this event type.", Logger::ERROR
          end
        end
        
        say "Ending another loop.", Logger::DEBUG
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
    
    
    
    protected
      
      def lock_next_event
        next_event = Event::Event.where('locked_at IS NULL AND execute_at < NOW()').order('execute_at DESC').first unless Rails.env.development?
        next_event = Event::Event.where("locked_at IS NULL AND execute_at < datetime('now')").order('execute_at DESC').first if Rails.env.development?
    #    next_event = Event::Event.where("execute_at < datetime('now')").order('execute_at DESC').first if Rails.env.development?
        
        if next_event
          say "Process event  #{next_event.id} of type #{next_event.event_type} (#{next_event.local_event_id})  that should be executed at #{next_event.execute_at}.", Logger::INFO
          next_event.locked_at = DateTime.now
          next_event.locked_by = 'ticker'
          next_event.save
          
          return next_event
        else
          say "idle", Logger::INFO
          return nil
        end
      end
      

  end
end
