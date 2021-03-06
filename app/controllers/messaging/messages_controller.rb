require 'httparty'
require 'net/http'
require 'identity_provider/access'


class Messaging::MessagesController < ApplicationController
  layout 'messaging'

  before_filter :authenticate
  before_filter :deny_api,        :except => [:show, :create]
  before_filter :authorize_staff, :except => [:show, :create]


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
    
    is_public = @messaging_message.type_id == Messaging::Message::ANNOUNCEMENT_TYPE_ID

    if @messaging_message.type_id == Messaging::Message::ALLIANCE_TYPE_ID && !current_character.nil? && roleRecipient != :owner && roleRecipient != :admin
      if @messaging_message.inbox_entries.where(owner_id: current_character.id).count >= 1
        roleRecipient = :owner
      end
    end
    
    role = roleSender == :default ? roleRecipient : roleSender          # chose the higher role by a trick: roleSender can only be :default or :owner (we do not care which one ot chose for :admin and :staff)
    raise ForbiddenError.new('Access Forbidden. Messages can only be accessed by sender, recipient and admins.') unless admin? || role == :owner || is_public
    
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
      
      if !params[:message].has_key?(:sender_id) && !current_character.nil?
        @messaging_message[:sender_id] = current_character.id
      end
      
      #resolve recipient (by name, id or to the whole alliance?)
      if params[:message].has_key? :recipient_name
        @recipient = Fundamental::Character.find_by_name_case_insensitive(params[:message][:recipient_name])
        raise NotFoundError.new('Unknown Recipient.')   if @recipient.nil?
        @messaging_message[:recipient_id] = @recipient.id
      elsif params[:message].has_key? :alliance_id
        raise ForbiddenError.new('Not allowed to send a mail to another alliance.')    if current_character.nil? || current_character.alliance_id != params[:message][:alliance_id].to_i
        raise ForbiddenError.new('Not allowed to send a mail to the whole alliance.')  if current_character.nil? || !current_character.alliance_leader?
        @messaging_message[:type_id] = Messaging::Message::ALLIANCE_TYPE_ID
      else
        @messaging_message[:recipient_id] = params[:message][:recipient_id].to_i
      end

      @messaging_message[:subject] = CGI::escapeHTML(params[:message][:subject] || "-")
      @messaging_message[:body]    = format_body(CGI::escapeHTML(params[:message][:body] || "")) # we have to escape html here, because the body field is displayed "raw" in the client. reason: we want to allow battle reports to be formatted with html    
    end 
    
    role = determine_access_role(@messaging_message.sender_id,    nil)    
    raise ForbiddenError.new("Tried to forge a message from another sender.") unless role == :owner || admin? || staff?
          
    raise BadRequestError.new('Malformed message could not be delivered.') unless @messaging_message.valid? 
    
    if !@messaging_message.save 
      raise BadRequestError.new('could not save and deliver message')  if event.save
    end

    @recipient ||= @messaging_message.recipient

    if !@recipient.nil? && @recipient.offline?
      ip_access = IdentityProvider::Access.new(
        identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
        game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
        scopes: ['5dentity'],
      )
      ip_access.deliver_message_notification(@recipient, @messaging_message.sender, @messaging_message)      
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
