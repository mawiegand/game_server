class Backend::BrowserStatsController < ApplicationController
  layout 'backend'

  before_filter :deny_api,                :except => [:create] 
# before_filter :authenticate,            :only   => [:create]  TODO reenable authemtication!
  before_filter :authenticate_backend,    :except => [:create] 
  before_filter :authorize_staff,         :except => [:create]
  

  # GET /backend/browser_stats
  def index
    @backend_browser_stats = Backend::BrowserStat.paginate(:order => 'created_at DESC', :page => params[:page], :per_page => 40)

    @last_failed = Backend::BrowserStat.failed.last(10)

    @num_failed_today = Backend::BrowserStat.failed.where('created_at > ?', DateTime.now - 1.days).count
    @num_total_today  = Backend::BrowserStat.where('created_at > ?', DateTime.now - 1.days).count
    
    @paginating = !params[:page].nil? && params[:page] > 0

    respond_to do |format|
      format.html # index.html.erb
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
    params[:backend_browser_stat][:identifier] = current_character.identifier unless current_character.nil?
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
