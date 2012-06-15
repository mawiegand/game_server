class Training::JobsController < ApplicationController
  layout 'training'
  
  # GET /training/jobs
  # GET /training/jobs.json
  def index
    @training_jobs = Training::Job.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @training_jobs }
    end
  end

  # GET /training/jobs/1
  # GET /training/jobs/1.json
  def show
    @training_job = Training::Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @training_job }
    end
  end

  # GET /training/jobs/new
  # GET /training/jobs/new.json
  def new
    @training_job = Training::Job.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @training_job }
    end
  end

  # GET /training/jobs/1/edit
  def edit
    @training_job = Training::Job.find(params[:id])
  end

  # POST /training/jobs
  # POST /training/jobs.json
  def create
    @training_job = Training::Job.new(params[:training_job])

    respond_to do |format|
      if @training_job.save
        format.html { redirect_to @training_job, notice: 'Job was successfully created.' }
        format.json { render json: @training_job, status: :created, location: @training_job }
      else
        format.html { render action: "new" }
        format.json { render json: @training_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /training/jobs/1
  # PUT /training/jobs/1.json
  def update
    @training_job = Training::Job.find(params[:id])

    respond_to do |format|
      if @training_job.update_attributes(params[:training_job])
        format.html { redirect_to @training_job, notice: 'Job was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @training_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /training/jobs/1
  # DELETE /training/jobs/1.json
  def destroy
    @training_job = Training::Job.find(params[:id])
    @training_job.destroy

    respond_to do |format|
      format.html { redirect_to training_jobs_url }
      format.json { head :ok }
    end
  end
end
