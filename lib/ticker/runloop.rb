module Ticker
  class Runloop
    
    DEFAULT_SLEEP_DELAY      = 1

    cattr_accessor :sleep_delay, :logger

    def self.reset
      self.sleep_delay      = DEFAULT_SLEEP_DELAY
    end    
    
    def initialize(options={})
      @quiet = options.has_key?(:quiet) ? options[:quiet] : true
      self.class.sleep_delay  = options[:sleep_delay] if options.has_key?(:sleep_delay)
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
        sleep(1)
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

  end
end