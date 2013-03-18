class Messaging::JabberCommandsController < ApplicationController
  layout 'messaging'

  before_filter :authenticate
  before_filter :authorize_staff
  before_filter :deny_api

  # GET /messaging/jabber_commands
  # GET /messaging/jabber_commands.json
  def index
    @messaging_jabber_commands = Messaging::JabberCommand.order('created_at DESC').paginate(:page => params[:page], :per_page => 50)
    @paginate = true

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messaging_jabber_commands }
    end
  end

  # GET /messaging/jabber_commands/1
  # GET /messaging/jabber_commands/1.json
  def show
    @messaging_jabber_command = Messaging::JabberCommand.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @messaging_jabber_command }
    end
  end

  # GET /messaging/jabber_commands/new
  # GET /messaging/jabber_commands/new.json
  def new
    @messaging_jabber_command = Messaging::JabberCommand.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @messaging_jabber_command }
    end
  end

  # GET /messaging/jabber_commands/1/edit
  def edit
    @messaging_jabber_command = Messaging::JabberCommand.find(params[:id])
  end

  # POST /messaging/jabber_commands
  # POST /messaging/jabber_commands.json
  def create
    @messaging_jabber_command = Messaging::JabberCommand.new(params[:messaging_jabber_command])

    respond_to do |format|
      if @messaging_jabber_command.save
        format.html { redirect_to @messaging_jabber_command, notice: 'Jabber command was successfully created.' }
        format.json { render json: @messaging_jabber_command, status: :created, location: @messaging_jabber_command }
      else
        format.html { render action: "new" }
        format.json { render json: @messaging_jabber_command.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messaging/jabber_commands/1
  # PUT /messaging/jabber_commands/1.json
  def update
    @messaging_jabber_command = Messaging::JabberCommand.find(params[:id])

    respond_to do |format|
      if @messaging_jabber_command.update_attributes(params[:messaging_jabber_command])
        format.html { redirect_to @messaging_jabber_command, notice: 'Jabber command was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @messaging_jabber_command.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messaging/jabber_commands/1
  # DELETE /messaging/jabber_commands/1.json
  def destroy
    @messaging_jabber_command = Messaging::JabberCommand.find(params[:id])
    @messaging_jabber_command.destroy

    respond_to do |format|
      format.html { redirect_to messaging_jabber_commands_url }
      format.json { head :ok }
    end
  end
end
