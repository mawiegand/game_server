begin
  require 'daemons'
rescue LoadError
  raise "You need to add gem 'daemons' to your Gemfile if you wish to use it."
end
require 'optparse'

# this daemon's runloop is based on delayed_job https://github.com/collectiveidea/delayed_job/

module Ticker
  class Command
    
    def initialize(args)
      @options = {
        :quiet => true,
        :pid_dir => "#{Rails.root}/tmp/pids",
        :identifier => 0
      }
      
      opts = OptionParser.new do |opts|
        opts.banner = "Usage: #{File.basename($0)} [options] start|stop|restart|run"

        opts.on('-h', '--help', 'Show this message') do
          puts opts
          exit 1
        end
        opts.on('-e', '--environment=NAME', 'Specifies the environment to run this delayed jobs under (test/development/production).') do |e|
          STDERR.puts "The -e/--environment option has been deprecated and has no effect. Use RAILS_ENV and see http://github.com/collectiveidea/delayed_job/issues/#issue/7"
        end
        opts.on('--pid-dir=DIR', 'Specifies an alternate directory in which to store the process ids.') do |dir|
          @options[:pid_dir] = dir
        end
        opts.on('-i', '--identifier=n', 'A numeric identifier for the worker.') do |n|
          @options[:identifier] = n
        end
        opts.on('--sleep-delay N', "Amount of time to sleep when no jobs are found") do |n|
          @options[:sleep_delay] = n
        end
        opts.on('-p', '--prefix NAME', "String to be prefixed to worker process names") do |prefix|
          @options[:prefix] = prefix
        end
      end
      @args = opts.parse!(args)      
    end
   
    def daemonize
      dir = @options[:pid_dir]
      Dir.mkdir(dir) unless File.exists?(dir)

      process_name = "ticker.#{@options[:identifier]}"
      run_process(process_name, dir)
    end

    def run_process(process_name, dir)
      Daemons.run_proc(process_name, :dir => dir, :dir_mode => :normal, :ARGV => @args) do |*args|
        $0 = File.join(@options[:prefix], process_name) if @options[:prefix]
        run process_name
      end
    end

    def run(worker_name = nil)
      Dir.chdir(Rails.root)
      
      logname = if Rails.env.development?
        'ticker_development.log'
      else
        'ticker_production.log'
      end
      
      Ticker::Runloop.logger ||= Logger.new(File.join(Rails.root, 'log', logname))

      runloop = Ticker::Runloop.new(@options)
      runloop.start
    rescue => e
     # Rails.logger.fatal e
      STDERR.puts e.message
      exit 1
    end
  end
end