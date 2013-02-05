class Messaging::InboxEntriesController < ApplicationController
  layout 'messaging'

  before_filter :authenticate
  before_filter :deny_api,      :except => [:index, :update, :destroy, :show]


  # GET /messaging/inbox_entries
  # GET /messaging/inbox_entries.json
  def index
    last_modified = nil
    
    role = :default # assume lowest possible role
    
    if params.has_key?(:inbox_id)
      @inbox = Messaging::Inbox.find(params[:inbox_id])
      raise NotFoundError.new('Inbox not found.') if @inbox.nil?
      role = determine_access_role(@inbox.owner_id, nil)   # no privileged alliance access
      raise ForbiddenError.new('Access to inbox denied.') unless role == :owner || admin? || staff?
      @messaging_inbox_entries = @inbox.entries.where("created_at >= ?", Time.now - 1209600) || []
      if !if_modified_since_time.nil?
        @messaging_inbox_entries = @messaging_inbox_entries.find_all { |entry| entry.updated_at > if_modified_since_time } 
      end
      @messaging_inbox_entries.each { |entry| last_modified = entry.updated_at   if last_modified.nil? || entry.updated_at > last_modified } 
    else
      @asked_for_index = true
      raise ForbiddenError.new('Access to index of inbox entries forbidden') unless admin? || staff?
    end

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          if @messaging_inbox_entries.nil?
            @messaging_inbox_entries = Messaging::InboxEntry.paginate(:page => params[:page], :per_page => 50)    
            @paginate = true   
          end 
        end
        format.json do
          raise ForbiddenError.new('Access Forbidden')    if @asked_for_index      
          render json: @messaging_inbox_entries, :only => Messaging::InboxEntry.readable_attributes(role)
        end
      end
    end    
  end

  # GET /messaging/inbox_entries/1
  # GET /messaging/inbox_entries/1.json
  def show
    last_modified = nil
    @messaging_inbox_entry = Messaging::InboxEntry.find(params[:id])
    
    role = :default # assume lowest possible role
    
    role = determine_access_role(@messaging_inbox_entry.owner_id, nil)   # no privileged alliance access
    raise ForbiddenError.new('Access to inbox denied.') unless role == :owner || admin? || staff?

    last_modified = @messaging_inbox_entry.updated_at

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @messaging_inbox_entry }
      end
    end
  end

  # GET /messaging/inbox_entries/new
  # GET /messaging/inbox_entries/new.json
  def new
    @messaging_inbox_entry = Messaging::InboxEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @messaging_inbox_entry }
    end
  end

  # GET /messaging/inbox_entries/1/edit
  def edit
    @messaging_inbox_entry = Messaging::InboxEntry.find(params[:id])
  end

  # POST /messaging/inbox_entries
  # POST /messaging/inbox_entries.json
  def create
    @messaging_inbox_entry = Messaging::InboxEntry.new(params[:messaging_inbox_entry])

    respond_to do |format|
      if @messaging_inbox_entry.save
        format.html { redirect_to @messaging_inbox_entry, notice: 'Inbox entry was successfully created.' }
        format.json { render json: @messaging_inbox_entry, status: :created, location: @messaging_inbox_entry }
      else
        format.html { render action: "new" }
        format.json { render json: @messaging_inbox_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messaging/inbox_entries/1
  # PUT /messaging/inbox_entries/1.json
  def update
    @messaging_inbox_entry = Messaging::InboxEntry.find(params[:id])
    
    role = :default # assume lowest possible role    
    role = determine_access_role(@messaging_inbox_entry.owner_id, nil)   # no privileged alliance access
    raise ForbiddenError.new('Access to inbox denied.') unless role == :owner || admin? || staff?
    
    attributes = params[:messaging_inbox_entry]
    attributes = { messaging_inbox_entry: { read: true }}  if role == :owner  # the only possible action is to mark it read

    respond_to do |format|
      if @messaging_inbox_entry.update_attributes(params[:messaging_inbox_entry])
        format.html { redirect_to @messaging_inbox_entry, notice: 'Inbox entry was successfully updated.' }
        format.json { render json: {}, status: :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @messaging_inbox_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messaging/inbox_entries/1
  # DELETE /messaging/inbox_entries/1.json
  def destroy
    @messaging_inbox_entry = Messaging::InboxEntry.find(params[:id])
    
    role = :default # assume lowest possible role    
    role = determine_access_role(@messaging_inbox_entry.owner_id, nil)   # no privileged alliance access
    raise ForbiddenError.new('Access to inbox denied.') unless role == :owner || admin? || staff?
    
    @messaging_inbox_entry.destroy

    respond_to do |format|
      format.html { redirect_to messaging_inbox_entries_url }
      format.json { render json: {}, status: :ok }
    end
  end
end
