class Messaging::OutboxEntriesController < ApplicationController
  layout 'messaging'

  # GET /messaging/outbox_entries
  # GET /messaging/outbox_entries.json
  def index
    @messaging_outbox_entries = Messaging::OutboxEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messaging_outbox_entries }
    end
  end

  # GET /messaging/outbox_entries/1
  # GET /messaging/outbox_entries/1.json
  def show
    @messaging_outbox_entry = Messaging::OutboxEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @messaging_outbox_entry }
    end
  end

  # GET /messaging/outbox_entries/new
  # GET /messaging/outbox_entries/new.json
  def new
    @messaging_outbox_entry = Messaging::OutboxEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @messaging_outbox_entry }
    end
  end

  # GET /messaging/outbox_entries/1/edit
  def edit
    @messaging_outbox_entry = Messaging::OutboxEntry.find(params[:id])
  end

  # POST /messaging/outbox_entries
  # POST /messaging/outbox_entries.json
  def create
    @messaging_outbox_entry = Messaging::OutboxEntry.new(params[:messaging_outbox_entry])

    respond_to do |format|
      if @messaging_outbox_entry.save
        format.html { redirect_to @messaging_outbox_entry, notice: 'Outbox entry was successfully created.' }
        format.json { render json: @messaging_outbox_entry, status: :created, location: @messaging_outbox_entry }
      else
        format.html { render action: "new" }
        format.json { render json: @messaging_outbox_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messaging/outbox_entries/1
  # PUT /messaging/outbox_entries/1.json
  def update
    @messaging_outbox_entry = Messaging::OutboxEntry.find(params[:id])

    respond_to do |format|
      if @messaging_outbox_entry.update_attributes(params[:messaging_outbox_entry])
        format.html { redirect_to @messaging_outbox_entry, notice: 'Outbox entry was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @messaging_outbox_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messaging/outbox_entries/1
  # DELETE /messaging/outbox_entries/1.json
  def destroy
    @messaging_outbox_entry = Messaging::OutboxEntry.find(params[:id])
    @messaging_outbox_entry.destroy

    respond_to do |format|
      format.html { redirect_to messaging_outbox_entries_url }
      format.json { head :ok }
    end
  end
end
