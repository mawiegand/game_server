class Messaging::InboxEntriesController < ApplicationController
  layout 'messaging'


  # GET /messaging/inbox_entries
  # GET /messaging/inbox_entries.json
  def index
    @messaging_inbox_entries = Messaging::InboxEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messaging_inbox_entries }
    end
  end

  # GET /messaging/inbox_entries/1
  # GET /messaging/inbox_entries/1.json
  def show
    @messaging_inbox_entry = Messaging::InboxEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @messaging_inbox_entry }
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

    respond_to do |format|
      if @messaging_inbox_entry.update_attributes(params[:messaging_inbox_entry])
        format.html { redirect_to @messaging_inbox_entry, notice: 'Inbox entry was successfully updated.' }
        format.json { head :ok }
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
    @messaging_inbox_entry.destroy

    respond_to do |format|
      format.html { redirect_to messaging_inbox_entries_url }
      format.json { head :ok }
    end
  end
end
