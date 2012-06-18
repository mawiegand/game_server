class Training::JobsController < ApplicationController
  layout 'training'
  
  before_filter :authenticate

  # GET /training/jobs
  # GET /training/jobs.json
  def index
    last_modified = nil
    
    if params.has_key?(:queue_id)
      @queue = Training::Queue.find(params[:queue_id])
      raise NotFoundError.new('Queue not found.') if @queue.nil?
      @training_jobs = @queue.jobs
      @training_jobs = [] if @training_jobs.nil?  # necessary? or ok to send 'null' ?
    else 
      @asked_for_index = true
    end   

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          if @training_jobs.nil?
            @training_jobs = Training::Job.paginate(:page => params[:page], :per_page => 50)    
            @paginate = true   
          end 
        end
        format.json do
          if @asked_for_index 
            raise ForbiddenError.new('Access Forbidden')        
          end  

          # role = determine_access_role(@character.id, @character.alliance_id)
          # logger.debug "Access with role #{role}."

          render :json => @training_jobs.to_json(:include => :active_job)
        end
      end
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
    @job = params[:training_job]
    
    @training_job = Training::Job.new(@job)
    raise ForbiddenError.new('wrong requirements') unless @training_job.queueable?
    queue = @training_job.queue
    @training_job.position = queue.max_position + 1
    @training_job.save
    
    queue.reload
    queue.check_for_new_jobs
    
    slot = @training_job.slot
    slot.job_created(@training_job)
    
    respond_to do |format|
      if @training_job.save
        format.html { redirect_to @training_job, notice: 'training job was successfully created.' }
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
