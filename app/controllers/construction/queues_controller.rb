class Construction::QueuesController < ApplicationController
  layout 'construction'

  before_filter :authenticate

  # GET /settlement/settlements/:settlement_id/queues
  # GET /settlement/settlements/:settlement_id/queues.json
  def index
    last_modified = nil
    
    if params.has_key?(:settlement_id)
      @settlement = Settlement::Settlement.find(params[:settlement_id])
      raise NotFoundError.new('Settlement not found.') if @settlement.nil?
      @construction_queues = @settlement.queues
      @construction_queues = [] if @construction_queues.nil?  # necessary? or ok to send 'null' ?
    else 
      @asked_for_index = true
    end   

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          if @construction_queues.nil?
            @construction_queues = Construction::Queue.paginate(:page => params[:page], :per_page => 50)    
            @paginate = true   
          end 
        end
        format.json do
          if @asked_for_index 
            raise ForbiddenError.new('Access Forbidden')    
          end  

          # role = determine_access_role(@character.id, @character.alliance_id)
          # logger.debug "Access with role #{role}."
          
          render :json => @construction_queues, :root => :construction_queue
        end
      end
    end
  end

  # GET /construction/queues/1
  # GET /construction/queues/1.json
  def show
    @construction_queue = Construction::Queue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json do
        logger.debug @construction_queue.inspect
        render :json => @construction_queue, :root => :construction_queue
      end
    end
  end

  # GET /construction/queues/new
  # GET /construction/queues/new.json
  def new
    @construction_queue = Construction::Queue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @construction_queue }
    end
  end

  # GET /construction/queues/1/edit
  def edit
    @construction_queue = Construction::Queue.find(params[:id])
  end

  # POST /construction/queues
  # POST /construction/queues.json
  def create
    @construction_queue = Construction::Queue.new(params[:construction_queue])

    respond_to do |format|
      if @construction_queue.save
        format.html { redirect_to @construction_queue, notice: 'Queue was successfully created.' }
        format.json { render json: @construction_queue, status: :created, location: @construction_queue }
      else
        format.html { render action: "new" }
        format.json { render json: @construction_queue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /construction/queues/1
  # PUT /construction/queues/1.json
  def update
    @construction_queue = Construction::Queue.find(params[:id])

    respond_to do |format|
      if @construction_queue.update_attributes(params[:construction_queue])
        format.html { redirect_to @construction_queue, notice: 'Queue was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @construction_queue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /construction/queues/1
  # DELETE /construction/queues/1.json
  def destroy
    @construction_queue = Construction::Queue.find(params[:id])
    @construction_queue.destroy

    respond_to do |format|
      format.html { redirect_to construction_queues_url }
      format.json { head :ok }
    end
  end
end
