class Backend::BrowserStatsController < ApplicationController
  layout 'backend'

  before_filter :deny_api,                :except => [:create] 
  before_filter :authenticate,            :only   => [:create]
  before_filter :authenticate_backend,    :except => [:create] 
  before_filter :authorize_staff,         :except => [:create]
  

  # GET /backend/browser_stats
  # GET /backend/browser_stats.json
  def index
    @backend_browser_stats = Backend::BrowserStat.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @backend_browser_stats }
    end
  end

  # GET /backend/browser_stats/1
  # GET /backend/browser_stats/1.json
  def show
    @backend_browser_stat = Backend::BrowserStat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @backend_browser_stat }
    end
  end

  # GET /backend/browser_stats/new
  # GET /backend/browser_stats/new.json
  def new
    @backend_browser_stat = Backend::BrowserStat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @backend_browser_stat }
    end
  end

  # GET /backend/browser_stats/1/edit
  def edit
    @backend_browser_stat = Backend::BrowserStat.find(params[:id])
  end

  # POST /backend/browser_stats
  # POST /backend/browser_stats.json
  def create
    params[:backend_browser_stat][:identifier] = current_character.identifier
    @backend_browser_stat = Backend::BrowserStat.new(params[:backend_browser_stat])

    respond_to do |format|
      if @backend_browser_stat.save
        format.html { redirect_to @backend_browser_stat, notice: 'Browser stat was successfully created.' }
        format.json { render json: @backend_browser_stat, status: :created, location: @backend_browser_stat }
      else
        format.html { render action: "new" }
        format.json { render json: @backend_browser_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /backend/browser_stats/1
  # PUT /backend/browser_stats/1.json
  def update
    @backend_browser_stat = Backend::BrowserStat.find(params[:id])

    respond_to do |format|
      if @backend_browser_stat.update_attributes(params[:backend_browser_stat])
        format.html { redirect_to @backend_browser_stat, notice: 'Browser stat was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @backend_browser_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /backend/browser_stats/1
  # DELETE /backend/browser_stats/1.json
  def destroy
    @backend_browser_stat = Backend::BrowserStat.find(params[:id])
    @backend_browser_stat.destroy

    respond_to do |format|
      format.html { redirect_to backend_browser_stats_url }
      format.json { head :ok }
    end
  end
end
