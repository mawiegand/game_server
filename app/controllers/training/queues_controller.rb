class Training::QueuesController < ApplicationController
  layout 'training'
  
  before_filter :authenticate

  # GET /settlement/settlements/:settlement_id/training_queues
  # GET /settlement/settlements/:settlement_id/training_queues.json
  def index
    last_modified = nil
    
    if params.has_key?(:settlement_id)
      @settlement = Settlement::Settlement.find(params[:settlement_id])
      raise NotFoundError.new('Settlement not found.') if @settlement.nil?
      @training_queues = @settlement.training_queues
      @training_queues = [] if @training_queues.nil?  # necessary? or ok to send 'null' ?
    else 
      @asked_for_index = true
    end   

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          if @training_queues.nil?
            @training_queues = Training::Queue.paginate(:page => params[:page], :per_page => 50)    
            @paginate = true
          end 
        end
        format.json do
          if @asked_for_index 
            raise ForbiddenError.new('Access Forbidden')        
          end  

          # role = determine_access_role(@character.id, @character.alliance_id)
          # logger.debug "Access with role #{role}."
          
          render :json => @training_queues.to_json(:include => :active_jobs)
        end
      end
    end
  end
  
  
  

  # GET /training/queues/1
  # GET /training/queues/1.json
  def show
    @training_queue = Training::Queue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @training_queue }
    end
  end

  # GET /training/queues/new
  # GET /training/queues/new.json
  def new
    @training_queue = Training::Queue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @training_queue }
    end
  end

  # GET /training/queues/1/edit
  def edit
    @training_queue = Training::Queue.find(params[:id])
  end

  # POST /training/queues
  # POST /training/queues.json
  def create
    @training_queue = Training::Queue.new(params[:training_queue])

    respond_to do |format|
      if @training_queue.save
        format.html { redirect_to @training_queue, notice: 'Queue was successfully created.' }
        format.json { render json: @training_queue, status: :created, location: @training_queue }
      else
        format.html { render action: "new" }
        format.json { render json: @training_queue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /training/queues/1
  # PUT /training/queues/1.json
  def update
    @training_queue = Training::Queue.find(params[:id])

    respond_to do |format|
      if @training_queue.update_attributes(params[:training_queue])
        format.html { redirect_to @training_queue, notice: 'Queue was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @training_queue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /training/queues/1
  # DELETE /training/queues/1.json
  def destroy
    @training_queue = Training::Queue.find(params[:id])
    @training_queue.destroy

    respond_to do |format|
      format.html { redirect_to training_queues_url }
      format.json { head :ok }
    end
  end
end
