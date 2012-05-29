class Construction::QueuesController < ApplicationController
  layout 'construction'

  # GET /construction/queues
  # GET /construction/queues.json
  def index
    @construction_queues = Construction::Queue.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @construction_queues }
    end
  end

  # GET /construction/queues/1
  # GET /construction/queues/1.json
  def show
    @construction_queue = Construction::Queue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @construction_queue }
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
