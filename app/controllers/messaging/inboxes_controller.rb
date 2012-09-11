class Messaging::InboxesController < ApplicationController
  layout 'messaging'
  
  before_filter :authenticate
  before_filter :deny_api,      :except => [:index, :show]

  # GET /messaging/inboxes
  # GET /messaging/inboxes.json
  def index
    last_modified = nil
    
    role = :default # assume lowest possible role
    
    if params.has_key?(:character_id)
      @character = Fundamental::Character.find(params[:character_id])
      raise NotFoundError.new('Character not found.') if @character.nil?
      inbox = @character.inbox 
      last_modified = inbox.updated_at if !inbox.nil?
      @messaging_inboxes = inbox.nil?  ? [] : [ inbox ]
      role = determine_access_role(@character.id, @character.alliance_id)
    else
      @asked_for_index = true
      raise ForbiddenError.new('AccessForbidden') unless admin? || staff?
    end

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          if @messaging_inboxes.nil?
            @messaging_inboxes = Messaging::Inbox.paginate(:page => params[:page], :per_page => 50)    
            @paginate = true   
          end 
        end
        format.json do
          raise ForbiddenError.new('Access Forbidden')    if @asked_for_index      
          render json: @messaging_inboxes, :only => Messaging::Inbox.readable_attributes(role)
        end
      end
    end
  end

  # GET /messaging/inboxes/1
  # GET /messaging/inboxes/1.json
  def show
    @messaging_inbox = Messaging::Inbox.find(params[:id])
    raise NotFoundError.new('Inbox Not Found') if @messaging_inbox.nil?

    role = determine_access_role(@messaging_inbox.owner_id, nil)  # no alliance access granted
    raise ForbiddenError.new('Not allowed to access inbox of other player.')  unless role == :owner || staff?
    
    last_modified = @messaging_inbox.updated_at
    
    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html # show.html.erb
        format.json do
          render json: @messaging_inbox, :only => Messaging::Inbox.readable_attributes(role)
        end
      end
    end 
  end

  # GET /messaging/inboxes/new
  # GET /messaging/inboxes/new.json
  def new
    @messaging_inbox = Messaging::Inbox.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @messaging_inbox }
    end
  end

  # GET /messaging/inboxes/1/edit
  def edit
    @messaging_inbox = Messaging::Inbox.find(params[:id])
  end

  # POST /messaging/inboxes
  # POST /messaging/inboxes.json
  def create
    @messaging_inbox = Messaging::Inbox.new(params[:messaging_inbox])

    respond_to do |format|
      if @messaging_inbox.save
        format.html { redirect_to @messaging_inbox, notice: 'Inbox was successfully created.' }
        format.json { render json: @messaging_inbox, status: :created, location: @messaging_inbox }
      else
        format.html { render action: "new" }
        format.json { render json: @messaging_inbox.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messaging/inboxes/1
  # PUT /messaging/inboxes/1.json
  def update
    @messaging_inbox = Messaging::Inbox.find(params[:id])

    respond_to do |format|
      if @messaging_inbox.update_attributes(params[:messaging_inbox])
        format.html { redirect_to @messaging_inbox, notice: 'Inbox was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @messaging_inbox.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messaging/inboxes/1
  # DELETE /messaging/inboxes/1.json
  def destroy
    @messaging_inbox = Messaging::Inbox.find(params[:id])
    @messaging_inbox.destroy

    respond_to do |format|
      format.html { redirect_to messaging_inboxes_url }
      format.json { head :ok }
    end
  end
end
