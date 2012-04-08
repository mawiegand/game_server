class Events::EventsController < ApplicationController
  # GET /events/events
  # GET /events/events.json
  def index
    @events_events = Events::Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events_events }
    end
  end

  # GET /events/events/1
  # GET /events/events/1.json
  def show
    @events_event = Events::Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @events_event }
    end
  end

  # GET /events/events/new
  # GET /events/events/new.json
  def new
    @events_event = Events::Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @events_event }
    end
  end

  # GET /events/events/1/edit
  def edit
    @events_event = Events::Event.find(params[:id])
  end

  # POST /events/events
  # POST /events/events.json
  def create
    @events_event = Events::Event.new(params[:events_event])

    respond_to do |format|
      if @events_event.save
        format.html { redirect_to @events_event, notice: 'Event was successfully created.' }
        format.json { render json: @events_event, status: :created, location: @events_event }
      else
        format.html { render action: "new" }
        format.json { render json: @events_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/events/1
  # PUT /events/events/1.json
  def update
    @events_event = Events::Event.find(params[:id])

    respond_to do |format|
      if @events_event.update_attributes(params[:events_event])
        format.html { redirect_to @events_event, notice: 'Event was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @events_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/events/1
  # DELETE /events/events/1.json
  def destroy
    @events_event = Events::Event.find(params[:id])
    @events_event.destroy

    respond_to do |format|
      format.html { redirect_to events_events_url }
      format.json { head :ok }
    end
  end
end
