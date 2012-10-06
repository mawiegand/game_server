class Backend::StatsController < ApplicationController
  layout 'backend'
  
  before_filter :deny_api
  before_filter :authenticate_backend  
  before_filter :authorize_staff

  
  # GET /backend/stats
  # GET /backend/stats.json
  def index
    @backend_stats = Backend::Stat.order('created_at ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @backend_stats }
    end
  end

  # GET /backend/stats/1
  # GET /backend/stats/1.json
  def show
    @backend_stat = Backend::Stat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @backend_stat }
    end
  end

  # GET /backend/stats/1/edit
  def edit
    @backend_stat = Backend::Stat.find(params[:id])
  end

  # POST /backend/stats
  # POST /backend/stats.json
  def create
    @backend_stat = Backend::Stat.new(params[:backend_stat])

    respond_to do |format|
      if @backend_stat.save
        Backend::Stat.update_all_character_stats
        Backend::Stat.update_all_cohorts
        
        format.html { redirect_to backend_stats_path, notice: 'Stat was successfully created.' }
        format.json { render json: @backend_stat, status: :created, location: @backend_stat }
      else
        format.html {  redirect_to backend_stats_path, notice: 'Stat could not be created.' }
        format.json { render json: @backend_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /backend/stats/1
  # PUT /backend/stats/1.json
  def update
    @backend_stat = Backend::Stat.find(params[:id])

    respond_to do |format|
      if @backend_stat.update_attributes(params[:backend_stat])
        format.html { redirect_to @backend_stat, notice: 'Stat was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @backend_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /backend/stats/1
  # DELETE /backend/stats/1.json
  def destroy
    @backend_stat = Backend::Stat.find(params[:id])
    @backend_stat.destroy

    respond_to do |format|
      format.html { redirect_to backend_stats_url }
      format.json { head :ok }
    end
  end
end
