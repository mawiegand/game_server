class Messaging::ArchivesController < ApplicationController
  layout 'messaging'

  # GET /messaging/archives
  # GET /messaging/archives.json
  def index
    @messaging_archives = Messaging::Archive.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messaging_archives }
    end
  end

  # GET /messaging/archives/1
  # GET /messaging/archives/1.json
  def show
    @messaging_archive = Messaging::Archive.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @messaging_archive }
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
