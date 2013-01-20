require 'identity_provider/access'

class Fundamental::HistoryEventsController < ApplicationController
  layout 'fundamental'
  
  before_filter :authenticate

  def index
    @fundamental_character = Fundamental::Character.find(params[:character_id])
	
    @fundamental_history_events = Fundamental::HistoryEvent.history_events_for_character_id(params[:character_id])
    @fundamental_history_events.each do |event|
      event['character_id'] = params[:character_id]
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_history_events }
    end
  end
end
