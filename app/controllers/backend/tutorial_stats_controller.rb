class Backend::TutorialStatsController < ApplicationController
  layout 'backend'
  
  before_filter :deny_api
  before_filter :authenticate_backend  
  before_filter :authorize_staff


  # GET /backend/tutorial_stats
  # GET /backend/tutorial_stats.json
  def index
    @backend_tutorial_stats = Backend::TutorialStat.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @backend_tutorial_stats }
    end
  end

  # GET /backend/tutorial_stats/1
  # GET /backend/tutorial_stats/1.json
  def show
    @backend_tutorial_stat = Backend::TutorialStat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @backend_tutorial_stat }
    end
  end

  # GET /backend/tutorial_stats/new
  # GET /backend/tutorial_stats/new.json
  def new
    @backend_tutorial_stat = Backend::TutorialStat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @backend_tutorial_stat }
    end
  end

  # GET /backend/tutorial_stats/1/edit
  def edit
    @backend_tutorial_stat = Backend::TutorialStat.find(params[:id])
  end

  # POST /backend/tutorial_stats
  # POST /backend/tutorial_stats.json
  def create
    @backend_tutorial_stat = Backend::TutorialStat.new(params[:backend_tutorial_stat])

    respond_to do |format|
      if @backend_tutorial_stat.save
        format.html { redirect_to @backend_tutorial_stat, notice: 'Tutorial stat was successfully created.' }
        format.json { render json: @backend_tutorial_stat, status: :created, location: @backend_tutorial_stat }
      else
        format.html { render action: "new" }
        format.json { render json: @backend_tutorial_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /backend/tutorial_stats/1
  # PUT /backend/tutorial_stats/1.json
  def update
    @backend_tutorial_stat = Backend::TutorialStat.find(params[:id])

    respond_to do |format|
      if @backend_tutorial_stat.update_attributes(params[:backend_tutorial_stat])
        format.html { redirect_to @backend_tutorial_stat, notice: 'Tutorial stat was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @backend_tutorial_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /backend/tutorial_stats/1
  # DELETE /backend/tutorial_stats/1.json
  def destroy
    @backend_tutorial_stat = Backend::TutorialStat.find(params[:id])
    @backend_tutorial_stat.destroy

    respond_to do |format|
      format.html { redirect_to backend_tutorial_stats_url }
      format.json { head :ok }
    end
  end
end
