require 'identity_provider/access'

class Fundamental::HistoryEventsController < ApplicationController
  layout 'fundamental'
  
  before_filter :authenticate

  def index
    @fundamental_character = Fundamental::Character.find(params[:character_id])
    
#    identity_provider_access = IdentityProvider::Access.new({
#      identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
#      game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
#      scopes:                     ['5dentity'],
#    })
#    response = identity_provider_access.fetch_history_events(@fundamental_character.identifier)
#    
#    if response.code == 200
#      @fundamental_history_events = response.parsed_response.nil? ? nil : response.parsed_response
      @fundamental_history_events = Fundamental::HistoryEvent.history_events_for_character_id(params[:character_id])
      @fundamental_history_events.each do |event|
        event['character_id'] = params[:character_id]
      end
#    elsif response.code == 404
#      @not_found = true
#    else
#      @error_code = response.code
#      @error = response.body
#    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_history_events }
    end
  end
end
