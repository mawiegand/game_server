class Messaging::InboxesController < ApplicationController
  layout 'messaging'

  # GET /messaging/inboxes
  # GET /messaging/inboxes.json
  def index
    @messaging_inboxes = Messaging::Inbox.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messaging_inboxes }
    end
  end

  # GET /messaging/inboxes/1
  # GET /messaging/inboxes/1.json
  def show
    @messaging_inbox = Messaging::Inbox.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @messaging_inbox }
    end
  end

  # GET /messaging/inboxes/new
  # GET /messaging/inboxes/new.json
  def new
    @messaging_inbox = Messaging::Inbox.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @messaging_inbox }
    end
  end

  # GET /messaging/inboxes/1/edit
  def edit
    @messaging_inbox = Messaging::Inbox.find(params[:id])
  end

  # POST /messaging/inboxes
  # POST /messaging/inboxes.json
  def create
    @messaging_inbox = Messaging::Inbox.new(params[:messaging_inbox])

    respond_to do |format|
      if @messaging_inbox.save
        format.html { redirect_to @messaging_inbox, notice: 'Inbox was successfully created.' }
        format.json { render json: @messaging_inbox, status: :created, location: @messaging_inbox }
      else
        format.html { render action: "new" }
        format.json { render json: @messaging_inbox.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messaging/inboxes/1
  # PUT /messaging/inboxes/1.json
  def update
    @messaging_inbox = Messaging::Inbox.find(params[:id])

    respond_to do |format|
      if @messaging_inbox.update_attributes(params[:messaging_inbox])
        format.html { redirect_to @messaging_inbox, notice: 'Inbox was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @messaging_inbox.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messaging/inboxes/1
  # DELETE /messaging/inboxes/1.json
  def destroy
    @messaging_inbox = Messaging::Inbox.find(params[:id])
    @messaging_inbox.destroy

    respond_to do |format|
      format.html { redirect_to messaging_inboxes_url }
      format.json { head :ok }
    end
  end
end
