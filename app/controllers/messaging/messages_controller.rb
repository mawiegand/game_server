class Messaging::MessagesController < ApplicationController
  layout 'messaging'

  before_filter :authenticate
  before_filter :deny_api,      :except => [:show, :create]


  # GET /messaging/messages
  # GET /messaging/messages.json
  def index
    @messaging_messages = Messaging::Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messaging_messages }
    end
  end

  # GET /messaging/messages/1
  # GET /messaging/messages/1.json
  def show
    @messaging_message = Messaging::Message.find(params[:id])
    raise NotFoundError.new('Message Not Found') if @messaging_message.nil?
    
    last_modified = @messaging_message.updated_at
    
    roleSender    = determine_access_role(@messaging_message.sender_id,    nil)
    roleRecipient = determine_access_role(@messaging_message.recipient_id, nil)
    
    role = roleSender == :default ? roleRecipient : roleSender          # chose the higher role by a trick: roleSender can only be :default or :owner (we do not care which one ot chose for :admin and :staff)
    raise ForbiddenError.new('Access Forbidden. Messages can only be accessed by sender, recipient and admins.') unless admin? || role == :owner
    
    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html {}
        format.json do
          render json: @messaging_message, :only => Messaging::Message.readable_attributes(role)
        end
      end
    end
  end

  # GET /messaging/messages/new
  # GET /messaging/messages/new.json
  def new
    @messaging_message = Messaging::Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @messaging_message }
    end
  end

  # GET /messaging/messages/1/edit
  def edit
    @messaging_message = Messaging::Message.find(params[:id])
  end

  # POST /messaging/messages
  # POST /messaging/messages.json
  def create
    if backend_request?
      @messaging_message = Messaging::Message.new(params[:messaging_message])
    else
      @messaging_message = Messaging::Message.new
      
      if params[:message].has_key? :recipient_name
        recipient = Fundamental::Character.find_by_name(params[:message][:recipient_name])
        raise BadRequestError.new('Unknown Recipient.')   if recipient.nil?
        @messaging_message[:recipient_id] = recipient.id
      else 
        @messaging_message[:recipient_id] = params[:message][:recipient_id]
      end
      
      if !params[:message].has_key?(:sender_id) && !current_character.nil?
        @messaging_message[:sender_id] = current_character.id
      end
      @messaging_message[:subject] = params[:message][:subject] || "-"
      @messaging_message[:body] = format_body(params[:message][:body] || "")
    end 
          
    raise BadRequestError.new('Malformed message could not be delivered.') unless @messaging_message.valid? 
    role = determine_access_role(@messaging_message.sender_id,    nil)    
    raise ForbiddenError.new("Tried to forge a message from another sender.") unless role == :owner || admin? || staff?

    if !@messaging_message.save 
      raise BadRequestError.new('could not save and deliver message')  if event.save
    end
        
    respond_to do |format|
      format.html do
        raise ForbiddenError.new('Backend Access Forbidden.') unless admin? || staff?
        redirect_to  @messaging_message, notice: 'Message was successfully created.' 
      end
      format.json { render json: [], status: :created, location: @messaging_message }
    end    
  end

  # PUT /messaging/messages/1
  # PUT /messaging/messages/1.json
  def update
    @messaging_message = Messaging::Message.find(params[:id])

    respond_to do |format|
      if @messaging_message.update_attributes(params[:messaging_message])
        format.html { redirect_to @messaging_message, notice: 'Message was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @messaging_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messaging/messages/1
  # DELETE /messaging/messages/1.json
  def destroy
    @messaging_message = Messaging::Message.find(params[:id])
    @messaging_message.destroy

    respond_to do |format|
      format.html { redirect_to messaging_messages_url }
      format.json { head :ok }
    end
  end
  
  protected
    
    def format_body(str)
      str.gsub(/\n/, '<br/>')
    end
end
