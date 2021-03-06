class Fundamental::AnnouncementsController < ApplicationController
  
  layout 'fundamental'
  
  before_filter :deny_api,             :except => [ :index, :show, :recent ]
  before_filter :authenticate_backend, :except => [ :index, :show, :recent ]
  before_filter :authorize_staff,      :except => [ :index, :show, :recent ]

  
  # GET /fundamental/announcements
  # GET /fundamental/announcements.json
  def index    
#   authorize_staff unless api_request?
    
    conditions = api_request? ? {locale: params[:language] || I18n.locale} : {original_id: nil}
    if api_request? && params.has_key?(:language) && params[:language] == "all"
      @fundamental_announcements = Fundamental::Announcement.order("created_at DESC")
    else 
      @fundamental_announcements = Fundamental::Announcement.where(conditions).order("created_at DESC")
    end

    last_modified = nil
    @fundamental_announcements.each do |announcement|
      last_modified = announcement.updated_at if last_modified.nil? || last_modified < announcement.updated_at
    end
    
    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @fundamental_announcements, methods: [ :author_name ]}
      end
    end
  end

  def recent
    @announcement = Fundamental::Announcement.where(:locale => I18n.locale).order("created_at DESC").first
    
    last_modified = @announcement.updated_at
    
    render_not_modified_or(last_modified) do
      render json: @announcement
    end
  end

  # GET /fundamental/announcements/1
  # GET /fundamental/announcements/1.json
  def show
#   authorize_staff unless api_request?

    @fundamental_announcement = Fundamental::Announcement.find(params[:id])
    
    last_modified = @fundamental_announcement.updated_at

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @fundamental_announcement, methods: [ :author_name ] }
      end
    end
  end

  # GET /fundamental/announcements/new
  # GET /fundamental/announcements/new.json
  def new
    if (params[:original_id])
      @original = Fundamental::Announcement.find_by_id(params[:original_id])
      raise NotFoundError.new "Original not found." if @original.nil?
      @fundamental_announcement = @original.translations.build
    else
      @fundamental_announcement = Fundamental::Announcement.new({
        :locale => I18n.default_locale
      })
    end

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
    @fundamental_announcement.author = current_backend_user

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
