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
    @system_messages = Backend::SystemMessage.new
  end  
  
end
