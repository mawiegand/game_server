class Training::ActiveJobsController < ApplicationController
  layout 'training'

  before_filter :authenticate
  before_filter :deny_api, :except => [:show, :index]

  
  # GET /training/active_jobs
  # GET /training/active_jobs.json
  def index
    @training_active_jobs = Training::ActiveJob.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @training_active_jobs }
    end
  end

  # GET /training/active_jobs/1
  # GET /training/active_jobs/1.json
  def show
    @training_active_job = Training::ActiveJob.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @training_active_job }
    end
  end

  # GET /training/active_jobs/new
  # GET /training/active_jobs/new.json
  def new
    @training_active_job = Training::ActiveJob.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @training_active_job }
    end
  end

  # GET /training/active_jobs/1/edit
  def edit
    @training_active_job = Training::ActiveJob.find(params[:id])
  end

  # POST /training/active_jobs
  # POST /training/active_jobs.json
  def create
    @training_active_job = Training::ActiveJob.new(params[:training_active_job])

    respond_to do |format|
      if @training_active_job.save
        format.html { redirect_to @training_active_job, notice: 'Active job was successfully created.' }
        format.json { render json: @training_active_job, status: :created, location: @training_active_job }
      else
        format.html { render action: "new" }
        format.json { render json: @training_active_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /training/active_jobs/1
  # PUT /training/active_jobs/1.json
  def update
    @training_active_job = Training::ActiveJob.find(params[:id])

    respond_to do |format|
      if @training_active_job.update_attributes(params[:training_active_job])
        format.html { redirect_to @training_active_job, notice: 'Active job was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @training_active_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /training/active_jobs/1
  # DELETE /training/active_jobs/1.json
  def destroy
    @training_active_job = Training::ActiveJob.find(params[:id])
    @training_active_job.destroy

    respond_to do |format|
      format.html { redirect_to training_active_jobs_url }
      format.json { head :ok }
    end
  end
end
