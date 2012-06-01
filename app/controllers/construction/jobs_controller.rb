class Construction::JobsController < ApplicationController
  layout 'construction'
  
  before_filter :authenticate

  # GET /construction/queues/:queue_id/jobs
  # GET /construction/queues/:queue_id/jobs.json
  def index
    last_modified = nil
    
    if params.has_key?(:queue_id)
      @queue = Construction::Queue.find(params[:queue_id])
      raise NotFoundError.new('Queue not found.') if @queue.nil?
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

          render :json => @construction_jobs.to_json(:include => :active_jobs)
        end
      end
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

  # POST /construction/queues/:queue_id/jobs
  # POST /construction/queues/:queue_id/jobs.json
  def create
    # queue holen mit Fehlerbehandlung
    # Job erzeugen mit Fehlerbehandlung
    # 
    
    # Kucken ob neuer Job direkt gestartet werden kann
    # -> Methode in Queue-Model?
    # wenn ja, aus Job neuen ActiveJob erzeugen
    # Fertigstellungszeitpunkt passend berechnen (queue.speed) und Formel

    @job = params[:construction_job]
    
    logger.debug "------------"
    logger.debug params.inspect
    logger.debug "------------"
    
    
    @construction_job = Construction::Job.new(@job)
    queue = @construction_job.queue
    @construction_job.level_after = @construction_job.level_before + 1
    @construction_job.position = queue.max_position + 1
    @construction_job.save
    
    queue.check_for_new_jobs
    
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
