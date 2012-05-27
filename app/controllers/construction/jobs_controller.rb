class Construction::JobsController < ApplicationController
  layout 'construction'

  # GET /construction/jobs
  # GET /construction/jobs.json
  def index
    @construction_jobs = Construction::Job.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @construction_jobs }
    end
  end

  # GET /construction/jobs/1
  # GET /construction/jobs/1.json
  def show
    @construction_job = Construction::Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @construction_job }
    end
  end

  # GET /construction/jobs/new
  # GET /construction/jobs/new.json
  def new
    @construction_job = Construction::Job.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @construction_job }
    end
  end

  # GET /construction/jobs/1/edit
  def edit
    @construction_job = Construction::Job.find(params[:id])
  end

  # POST /construction/jobs
  # POST /construction/jobs.json
  def create
    @construction_job = Construction::Job.new(params[:construction_job])

    respond_to do |format|
      if @construction_job.save
        format.html { redirect_to @construction_job, notice: 'Job was successfully created.' }
        format.json { render json: @construction_job, status: :created, location: @construction_job }
      else
        format.html { render action: "new" }
        format.json { render json: @construction_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /construction/jobs/1
  # PUT /construction/jobs/1.json
  def update
    @construction_job = Construction::Job.find(params[:id])

    respond_to do |format|
      if @construction_job.update_attributes(params[:construction_job])
        format.html { redirect_to @construction_job, notice: 'Job was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @construction_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /construction/jobs/1
  # DELETE /construction/jobs/1.json
  def destroy
    @construction_job = Construction::Job.find(params[:id])
    @construction_job.destroy

    respond_to do |format|
      format.html { redirect_to construction_jobs_url }
      format.json { head :ok }
    end
  end
end
