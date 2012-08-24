class Messaging::ArchiveEntriesController < ApplicationController
  layout 'messaging'

  before_filter :authenticate
  
  
  # GET /messaging/archive_entries
  # GET /messaging/archive_entries.json
  def index
    @messaging_archive_entries = Messaging::ArchiveEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messaging_archive_entries }
    end
  end

  # GET /messaging/archive_entries/1
  # GET /messaging/archive_entries/1.json
  def show
    @messaging_archive_entry = Messaging::ArchiveEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @messaging_archive_entry }
    end
  end

  # GET /messaging/archive_entries/new
  # GET /messaging/archive_entries/new.json
  def new
    @messaging_archive_entry = Messaging::ArchiveEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @messaging_archive_entry }
    end
  end

  # GET /messaging/archive_entries/1/edit
  def edit
    @messaging_archive_entry = Messaging::ArchiveEntry.find(params[:id])
  end

  # POST /messaging/archive_entries
  # POST /messaging/archive_entries.json
  def create
    @messaging_archive_entry = Messaging::ArchiveEntry.new(params[:messaging_archive_entry])

    respond_to do |format|
      if @messaging_archive_entry.save
        format.html { redirect_to @messaging_archive_entry, notice: 'Archive entry was successfully created.' }
        format.json { render json: @messaging_archive_entry, status: :created, location: @messaging_archive_entry }
      else
        format.html { render action: "new" }
        format.json { render json: @messaging_archive_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messaging/archive_entries/1
  # PUT /messaging/archive_entries/1.json
  def update
    @messaging_archive_entry = Messaging::ArchiveEntry.find(params[:id])

    respond_to do |format|
      if @messaging_archive_entry.update_attributes(params[:messaging_archive_entry])
        format.html { redirect_to @messaging_archive_entry, notice: 'Archive entry was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @messaging_archive_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messaging/archive_entries/1
  # DELETE /messaging/archive_entries/1.json
  def destroy
    @messaging_archive_entry = Messaging::ArchiveEntry.find(params[:id])
    @messaging_archive_entry.destroy

    respond_to do |format|
      format.html { redirect_to messaging_archive_entries_url }
      format.json { head :ok }
    end
  end
end
