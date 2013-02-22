class Messaging::ArchiveEntriesController < ApplicationController
  layout 'messaging'

  before_filter :authenticate
  before_filter :deny_api,      :except => [:index, :update, :destroy, :show]

  # GET /messaging/archive_entries
  # GET /messaging/archive_entries.json
  def index
    last_modified = nil

    role = :default # assume lowest possible role

    if params.has_key?(:archive_id)
      @archive = Messaging::Archive.find(params[:archive_id])
      raise NotFoundError.new('Archive not found.') if @archive.nil?
      role = determine_access_role(@archive.owner_id, nil)   # no privileged alliance access
      raise ForbiddenError.new('Access to inbox denied.') unless role == :owner || admin? || staff?
      @messaging_archive_entries = @archive.entries
      unless if_modified_since_time.nil?
        @messaging_archive_entries = @messaging_archive_entries.find_all { |entry| entry.updated_at > if_modified_since_time }
      end
      @messaging_archive_entries.each { |entry| last_modified = entry.updated_at   if last_modified.nil? || entry.updated_at > last_modified }
    else
      @asked_for_index = true
      raise ForbiddenError.new('Access to index of archive entries forbidden') unless admin? || staff?
    end

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          if @messaging_archive_entries.nil?
            @messaging_archive_entries = Messaging::ArchiveEntry.paginate(:page => params[:page], :per_page => 50)
            @paginate = true
          end
        end
        format.json do
          raise ForbiddenError.new('Access Forbidden')    if @asked_for_index
          render json: @messaging_archive_entries, :only => Messaging::ArchiveEntry.readable_attributes(role)
        end
      end
    end
  end

  # GET /messaging/archive_entries/1
  # GET /messaging/archive_entries/1.json
  def show
    @messaging_archive_entry = Messaging::ArchiveEntry.find(params[:id])

    role = determine_access_role(@messaging_archive_entry.owner_id, nil)   # no privileged alliance access
    raise ForbiddenError.new('Access to archive denied.') unless role == :owner || admin? || staff?

    last_modified = @messaging_archive_entry.updated_at

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @messaging_archive_entry }
      end
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

    role = determine_access_role(@messaging_archive_entry.owner_id, nil)   # no privileged alliance access
    raise ForbiddenError.new('Access to inbox denied.') unless role == :owner || admin? || staff?

    @messaging_archive_entry.destroy

    respond_to do |format|
      format.html { redirect_to messaging_inbox_entries_url }
      format.json { render json: {}, status: :ok }
    end
  end

end
