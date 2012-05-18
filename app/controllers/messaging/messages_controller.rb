class Messaging::MessagesController < ApplicationController
  layout 'messaging'

  # GET /messaging/messages
  # GET /messaging/messages.json
  def index
    @messaging_messages = Messaging::Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messaging_messages }
    end
  end

  # GET /messaging/messages/1
  # GET /messaging/messages/1.json
  def show
    @messaging_message = Messaging::Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @messaging_message }
    end
  end

  # GET /messaging/messages/new
  # GET /messaging/messages/new.json
  def new
    @messaging_message = Messaging::Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @messaging_message }
    end
  end

  # GET /messaging/messages/1/edit
  def edit
    @messaging_message = Messaging::Message.find(params[:id])
  end

  # POST /messaging/messages
  # POST /messaging/messages.json
  def create
    @messaging_message = Messaging::Message.new(params[:messaging_message])

    respond_to do |format|
      if @messaging_message.save
        format.html { redirect_to @messaging_message, notice: 'Message was successfully created.' }
        format.json { render json: @messaging_message, status: :created, location: @messaging_message }
      else
        format.html { render action: "new" }
        format.json { render json: @messaging_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messaging/messages/1
  # PUT /messaging/messages/1.json
  def update
    @messaging_message = Messaging::Message.find(params[:id])

    respond_to do |format|
      if @messaging_message.update_attributes(params[:messaging_message])
        format.html { redirect_to @messaging_message, notice: 'Message was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @messaging_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messaging/messages/1
  # DELETE /messaging/messages/1.json
  def destroy
    @messaging_message = Messaging::Message.find(params[:id])
    @messaging_message.destroy

    respond_to do |format|
      format.html { redirect_to messaging_messages_url }
      format.json { head :ok }
    end
  end
end
