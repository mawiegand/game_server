class Construction::ActiveJobsController < ApplicationController
  layout 'construction'
  
  before_filter :authenticate


  # GET /construction/active_jobs
  # GET /construction/active_jobs.json
  def index
    @construction_active_jobs = Construction::ActiveJob.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @construction_active_jobs }
    end
  end

  # GET /construction/active_jobs/1
  # GET /construction/active_jobs/1.json
  def show
    @construction_active_job = Construction::ActiveJob.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @construction_active_job }
    end
  end

  # GET /construction/active_jobs/new
  # GET /construction/active_jobs/new.json
  def new
    @construction_active_job = Construction::ActiveJob.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @construction_active_job }
    end
  end

  # GET /construction/active_jobs/1/edit
  def edit
    @construction_active_job = Construction::ActiveJob.find(params[:id])
  end

  # POST /construction/active_jobs
  # POST /construction/active_jobs.json
  def create
    @construction_active_job = Construction::ActiveJob.new(params[:construction_active_job])

    respond_to do |format|
      if @construction_active_job.save
        format.html { redirect_to @construction_active_job, notice: 'Active job was successfully created.' }
        format.json { render json: @construction_active_job, status: :created, location: @construction_active_job }
      else
        format.html { render action: "new" }
        format.json { render json: @construction_active_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /construction/active_jobs/1
  # PUT /construction/active_jobs/1.json
  def update
    @construction_active_job = Construction::ActiveJob.find(params[:id])

    respond_to do |format|
      if @construction_active_job.update_attributes(params[:construction_active_job])
        format.html { redirect_to @construction_active_job, notice: 'Active job was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @construction_active_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /construction/active_jobs/1
  # DELETE /construction/active_jobs/1.json
  def destroy
    @construction_active_job = Construction::ActiveJob.find(params[:id])
    @construction_active_job.destroy

    respond_to do |format|
      format.html { redirect_to construction_active_jobs_url }
      format.json { head :ok }
    end
  end
end
