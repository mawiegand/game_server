class Messaging::OutboxesController < ApplicationController
  layout 'messaging'

  before_filter :authenticate
  before_filter :deny_api,      :except => [:index, :show]


  # GET /messaging/outboxes
  # GET /messaging/outboxes.json
  def index
    last_modified = nil
    
    role = :default # assume lowest possible role
    
    if params.has_key?(:character_id)
      @character = Fundamental::Character.find(params[:character_id])
      raise NotFoundError.new('Character not found.') if @character.nil?
      outbox = @character.outbox 
      last_modified = outbox.updated_at if !outbox.nil?
      @messaging_outboxes = outbox.nil?  ? [] : [ outbox ]
      role = determine_access_role(@character.id, @character.alliance_id)
    else
      @asked_for_index = true
      raise ForbiddenError.new('AccessForbidden') unless admin? || staff?
    end

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          if @messaging_outboxes.nil?
            @messaging_outboxes = Messaging::Outbox.paginate(:page => params[:page], :per_page => 50)    
            @paginate = true   
          end 
        end
        format.json do
          raise ForbiddenError.new('Access Forbidden')    if @asked_for_index      
          render json: @messaging_outboxes, :only => Messaging::Outbox.readable_attributes(role)
        end
      end
    end    
  end

  # GET /messaging/outboxes/1
  # GET /messaging/outboxes/1.json
  def show
    @messaging_outboxes = Messaging::Outbox.find(params[:id])
    raise NotFoundError.new('Outbox Not Found') if @messaging_outboxes.nil?

    last_modified = @messaging_outboxes.updated_at

    role = determine_access_role(@messaging_outboxes.owner_id, nil)  # no alliance access granted
    
    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html # show.html.erb
        format.json do
          render json: @messaging_outboxes, :only => Messaging::Outbox.readable_attributes(role)
        end
      end
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
