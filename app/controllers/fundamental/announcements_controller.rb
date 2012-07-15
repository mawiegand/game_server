class Fundamental::AnnouncementsController < ApplicationController
  # GET /fundamental/announcements
  # GET /fundamental/announcements.json
  def index
    @fundamental_announcements = Fundamental::Announcement.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fundamental_announcements }
    end
  end

  # GET /fundamental/announcements/1
  # GET /fundamental/announcements/1.json
  def show
    @fundamental_announcement = Fundamental::Announcement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_announcement }
    end
  end

  # GET /fundamental/announcements/new
  # GET /fundamental/announcements/new.json
  def new
    @fundamental_announcement = Fundamental::Announcement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_announcement }
    end
  end

  # GET /fundamental/announcements/1/edit
  def edit
    @fundamental_announcement = Fundamental::Announcement.find(params[:id])
  end

  # POST /fundamental/announcements
  # POST /fundamental/announcements.json
  def create
    @fundamental_announcement = Fundamental::Announcement.new(params[:fundamental_announcement])

    respond_to do |format|
      if @fundamental_announcement.save
        format.html { redirect_to @fundamental_announcement, notice: 'Announcement was successfully created.' }
        format.json { render json: @fundamental_announcement, status: :created, location: @fundamental_announcement }
      else
        format.html { render action: "new" }
        format.json { render json: @fundamental_announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundamental/announcements/1
  # PUT /fundamental/announcements/1.json
  def update
    @fundamental_announcement = Fundamental::Announcement.find(params[:id])

    respond_to do |format|
      if @fundamental_announcement.update_attributes(params[:fundamental_announcement])
        format.html { redirect_to @fundamental_announcement, notice: 'Announcement was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/announcements/1
  # DELETE /fundamental/announcements/1.json
  def destroy
    @fundamental_announcement = Fundamental::Announcement.find(params[:id])
    @fundamental_announcement.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_announcements_url }
      format.json { head :ok }
    end
  end
end
