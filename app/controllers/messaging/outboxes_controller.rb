class Messaging::OutboxesController < ApplicationController
  layout 'messaging'

  # GET /messaging/outboxes
  # GET /messaging/outboxes.json
  def index
    @messaging_outboxes = Messaging::Outbox.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messaging_outboxes }
    end
  end

  # GET /messaging/outboxes/1
  # GET /messaging/outboxes/1.json
  def show
    @messaging_outbox = Messaging::Outbox.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @messaging_outbox }
    end
  end

  # GET /messaging/outboxes/new
  # GET /messaging/outboxes/new.json
  def new
    @messaging_outbox = Messaging::Outbox.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @messaging_outbox }
    end
  end

  # GET /messaging/outboxes/1/edit
  def edit
    @messaging_outbox = Messaging::Outbox.find(params[:id])
  end

  # POST /messaging/outboxes
  # POST /messaging/outboxes.json
  def create
    @messaging_outbox = Messaging::Outbox.new(params[:messaging_outbox])

    respond_to do |format|
      if @messaging_outbox.save
        format.html { redirect_to @messaging_outbox, notice: 'Outbox was successfully created.' }
        format.json { render json: @messaging_outbox, status: :created, location: @messaging_outbox }
      else
        format.html { render action: "new" }
        format.json { render json: @messaging_outbox.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messaging/outboxes/1
  # PUT /messaging/outboxes/1.json
  def update
    @messaging_outbox = Messaging::Outbox.find(params[:id])

    respond_to do |format|
      if @messaging_outbox.update_attributes(params[:messaging_outbox])
        format.html { redirect_to @messaging_outbox, notice: 'Outbox was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @messaging_outbox.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messaging/outboxes/1
  # DELETE /messaging/outboxes/1.json
  def destroy
    @messaging_outbox = Messaging::Outbox.find(params[:id])
    @messaging_outbox.destroy

    respond_to do |format|
      format.html { redirect_to messaging_outboxes_url }
      format.json { head :ok }
    end
  end
end
