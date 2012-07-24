require 'httparty'
require 'net/http'
require 'identity_provider/access'

class Fundamental::PersistentCharacterPropertiesController < ApplicationController
  layout 'fundamental'

  before_filter :authenticate
  before_filter :deny_api
  
  def show
    @fundamental_character = Fundamental::Character.find(params[:id])

    ip_access = IdentityProvider::Access.new(
      identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
      game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
      scopes: ['5dentity'],
    )
    response = ip_access.fetch_identity_properties(@fundamental_character.identifier)
    
    if response.code    == 200
      @properties = response.parsed_response.nil? ? nil : response.parsed_response
    elsif response.code == 404
      @not_found = true
    else
      @error_code = response.code
      @error = response.body
    end

    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
end
