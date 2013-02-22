class Messaging::ArchivesController < ApplicationController
  layout 'messaging'

  before_filter :authenticate


  # GET /messaging/archives
  # GET /messaging/archives.json
  def index
    last_modified = nil

    role = :default # assume lowest possible role

    if params.has_key?(:character_id)
      @character = Fundamental::Character.find(params[:character_id])
      raise NotFoundError.new('Character not found.') if @character.nil?
      archive = @character.archive
      last_modified = archive.updated_at unless archive.nil?
      @messaging_archivees = archive.nil?  ? [] : [ archive ]
      role = determine_access_role(@character.id, @character.alliance_id)
    else
      @asked_for_index = true
      raise ForbiddenError.new('AccessForbidden') unless admin? || staff?
    end

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          if @messaging_archivees.nil?
            @messaging_archivees = Messaging::Outbox.paginate(:page => params[:page], :per_page => 50)
            @paginate = true
          end
        end
        format.json do
          raise ForbiddenError.new('Access Forbidden')    if @asked_for_index
          render json: @messaging_archivees, :only => Messaging::Archive.readable_attributes(role)
        end
      end
    end
  end



  # GET /messaging/archives/1
  # GET /messaging/archives/1.json
  def show
    @messaging_archive = Messaging::Archive.find(params[:id])
    raise NotFoundError.new('Archive Not Found') if @messaging_archive.nil?

    last_modified = @messaging_archive.updated_at

    role = determine_access_role(@messaging_archive.owner_id, nil)  # no alliance access granted

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html # show.html.erb
        format.json do
          render json: @messaging_archive, :only => Messaging::Archive.readable_attributes(role)
        end
      end
    end
  end


  # GET /messaging/archives/new
  # GET /messaging/archives/new.json
  def new
    @messaging_archive = Messaging::Archive.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @messaging_archive }
    end
  end

  # GET /messaging/archives/1/edit
  def edit
    @messaging_archive = Messaging::Archive.find(params[:id])
  end

  # POST /messaging/archives
  # POST /messaging/archives.json
  def create
    @messaging_archive = Messaging::Archive.new(params[:messaging_archive])

    respond_to do |format|
      if @messaging_archive.save
        format.html { redirect_to @messaging_archive, notice: 'Archive was successfully created.' }
        format.json { render json: @messaging_archive, status: :created, location: @messaging_archive }
      else
        format.html { render action: "new" }
        format.json { render json: @messaging_archive.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messaging/archives/1
  # PUT /messaging/archives/1.json
  def update
    @messaging_archive = Messaging::Archive.find(params[:id])

    respond_to do |format|
      if @messaging_archive.update_attributes(params[:messaging_archive])
        format.html { redirect_to @messaging_archive, notice: 'Archive was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @messaging_archive.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messaging/archives/1
  # DELETE /messaging/archives/1.json
  def destroy
    @messaging_archive = Messaging::Archive.find(params[:id])
    @messaging_archive.destroy

    respond_to do |format|
      format.html { redirect_to messaging_archives_url }
      format.json { head :ok }
    end
  end
end
