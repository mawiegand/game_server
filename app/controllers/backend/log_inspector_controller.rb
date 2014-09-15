class Backend::LogInspectorController < ApplicationController
  layout 'backend'

  before_filter :deny_api              
  before_filter :authenticate_backend
  before_filter :authorize_staff

  # GET /backend/log_inspector/regex
  def show
    @path = if (params[:log] || "").to_s == "server" 
      Rails.application.config.paths['log'].first
    else # assuming ticker!
      File.join(Rails.root, 'log', "ticker_#{Rails.env}.log")
    end

    @string = params[:regex] || "ERROR"
    @lines  = []
    @hits   = 0
    
    first_line = nil

    if File.exist?(@path)
    
      logfile = File.open(@path, "r")
      regex   = Regexp.new(@string)
      counter = 0
      after_lines = (params[:after] || "5").to_i
    
      logfile.each_line do |line|
        first_line = first_line || line
        
        if line =~ regex
          @lines << line.gsub(regex){|x| "<b>#{x}</b>" }
          counter = after_lines
          @hits += 1
        elsif counter > 0
          @lines << line
          counter -= 1
          if counter == 0
            @lines << " --- "
          end
        end
      end
      
      logfile.close
      
      if @hits == 0
        @lines << "Logfile starts with:" << first_line
      end
    else
      @lines << "File does not exist."
    end
        
    respond_to do |format|
      format.html # show.html.erb
    end
  end
end