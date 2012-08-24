class Event::EventsController < ApplicationController
  layout 'event'  
  
  before_filter :authenticate
  
  
  # GET /events/events
  # GET /events/events.json
  def index
    @event_events = Event::Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @event_events }
    end
  end

  # GET /events/events/1
  # GET /events/events/1.json
  def show
    @event_event = Event::Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event_event }
    end
  end

  # GET /events/events/new
  # GET /events/events/new.json
  def new
    @event_event = Event::Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event_event }
    end
  end

  # GET /events/events/1/edit
  def edit
    @event_event = Event::Event.find(params[:id])
  end

  # POST /events/events
  # POST /events/events.json
  def create
    @event_event = Event::Event.new(params[:event_event])

    respond_to do |format|
      if @event_event.save
        format.html { redirect_to @event_event, notice: 'Event was successfully created.' }
        format.json { render json: @event_event, status: :created, location: @event_event }
      else
        format.html { render action: "new" }
        format.json { render json: @event_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/events/1
  # PUT /events/events/1.json
  def update
    @event_event = Event::Event.find(params[:id])

    respond_to do |format|
      if @event_event.update_attributes(params[:event_event])
        format.html { redirect_to @event_event, notice: 'Event was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @event_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/events/1
  # DELETE /events/events/1.json
  def destroy
    @event_event = Event::Event.find(params[:id])
    @event_event.destroy

    respond_to do |format|
      format.html { redirect_to event_events_url }
      format.json { head :ok }
    end
  end
end
