class Construction::JobsController < ApplicationController
  layout 'construction'
  
  before_filter :authenticate
  before_filter :deny_api, :except => [:show, :index, :create, :destroy]


  # GET /construction/queues/:queue_id/jobs
  # GET /construction/queues/:queue_id/jobs.json
  def index
    last_modified = nil
    
    if params.has_key?(:queue_id)
      @queue = Construction::Queue.find(params[:queue_id])
      raise NotFoundError.new('Queue not found.') if @queue.nil?
      raise ForbiddenError.new('not owner of queue') unless @queue.settlement.owner == current_character || admin? || staff? || developer?

      @construction_jobs = @queue.jobs
      @construction_jobs = [] if @construction_jobs.nil?  # necessary? or ok to send 'null' ?
    else 
      @asked_for_index = true
    end   

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          if @construction_jobs.nil?
            @construction_jobs = Construction::Job.paginate(:page => params[:page], :per_page => 50)    
            @paginate = true   
          end 
        end
        format.json do
          if @asked_for_index 
            raise ForbiddenError.new('Access Forbidden')        
          end  

          # role = determine_access_role(@character.id, @character.alliance_id)
          # logger.debug "Access with role #{role}."

          render :json => @construction_jobs.to_json(:include => :active_job)
        end
      end
    end
  end

  # GET /construction/jobs/1
  # GET /construction/jobs/1.json
  def show
    @construction_job = Construction::Job.find(params[:id])

    raise ForbiddenError.new('not owner of job') unless @construction_job.queue.settlement.owner == current_character

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

  # POST /construction/queues/:queue_id/jobs
  # POST /construction/queues/:queue_id/jobs.json
  def create
    @job = params[:construction_job]
    
    @construction_job = nil
    queue = nil
    
    Construction::Job.transaction do
      @construction_job = Construction::Job.new(@job)
      raise ForbiddenError.new('not owner of settlement') unless @construction_job.slot.settlement.owner == current_character
      raise ForbiddenError.new('wrong requirements') unless @construction_job.queueable?
      queue = @construction_job.queue
      @construction_job.position = queue.max_position + 1
      @construction_job.save
    end
    
    queue.reload
    queue.check_for_new_jobs
    
    slot = @construction_job.slot
    slot.job_created(@construction_job)
    
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
    Construction::Job.transaction do
      @construction_job = Construction::Job.lock.find(params[:id])
    
      raise ForbiddenError.new('not owner of job') unless @construction_job.queue.settlement.owner == current_character

      # test if there are jobs depending on this one, if not, remove job
    
      queue = @construction_job.queue
    
      # call cancel at slot to remove the building id if there is no building in slot
      if @construction_job.last_in_slot
        @construction_job.slot.job_cancelled(@construction_job)
        @construction_job.refund_for_job if @construction_job.active?
        @construction_job.destroy
        queue.reload
        queue.check_for_new_jobs
      else
        raise ForbiddenError.new('Could only remove last job of slot')        
      end
    end

    respond_to do |format|
      format.html { redirect_to construction_jobs_url }
      format.json { head :ok }
    end
  end
end
