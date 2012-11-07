class Backend::SystemMessagesController < ApplicationController
  layout 'backend'  
  
  before_filter :deny_api
  before_filter :authenticate_backend
  before_filter :authorize_staff

  def index
    @system_messages = Messaging::Message.system.paginate(:order => 'created_at DESC', :page => params[:page], :per_page => 10)
  end  

  # GET /backend/browser_stats/new
  def new
    @system_message = Messaging::Message.new
  end  
  
  
  def create
    @system_message = Messaging::Message.new(params[:messaging_message])
    if params.has_key? :deliver                         # deliver message
      @system_message.type_id = Messaging::Message::ANNOUNCEMENT_TYPE_ID
      if @system_message.save
        redirect_to action: "index", notice: 'System message was successfully created.'    
         
      # TODO : delay this!   
      #  if params.has_key? :notify_offline
      #    @system_message.notify_offline_recipients
      #  end
      else
        render action: "new", flash: 'Could not be delivered.'
      end
    else
      render action: "new"                              # just present preview
    end
  end

  
end
