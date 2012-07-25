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
      @properties = response.parsed_response.nil? ? nil : response.parsed_response[0]
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
  
  # GET /fundamental/persistent_character_properties/1/edit
  def edit
    @fundamental_character = Fundamental::Character.find(params[:id])
    
    ip_access = IdentityProvider::Access.new(
      identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
      game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
      scopes: ['5dentity'],
    )
    response = ip_access.fetch_identity_properties(@fundamental_character.identifier)
    
    if response.code   == 200
      @properties = response.parsed_response.nil? ? nil : response.parsed_response[0]
    else # e.g. 404
      raise NotFoundError.new "Could not fetch properties from identity provider."
    end
    
    respond_to do |format|
      format.html # show.html.erb
    end    
    
  end
  

  # POST /fundamental/persistent_character_properties
  def create
    
    raise BadRequestError.new 'identity id was missing'   if params[:identity_id].blank?
    properties = params.has_key?(:properties) ? params[:properties] : nil
    character = Fundamental::Character.find_by_identifier(params[:identity_id])
    raise BadRequestError.new 'character with identifier #{params[:identity_id]} not found.' if character.nil?
    
    ip_access = IdentityProvider::Access.new(
      identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
      game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
      scopes: ['5dentity'],
    )
    response = ip_access.create_character_property(params[:identity_id], properties)
    

    respond_to do |format|
      if response.code == 200 || response.code == 201
        format.html { redirect_to fundamental_persistent_character_property_path(character.id), notice: 'Character Property was successfully created.' }
      else
        format.html { redirect_to fundamental_persistent_character_property_path(character.id), notice: 'Character Property could not be created.' }
      end
    end
  end
  
  # PUT /fundamental/persistent_character_properties/1
  def update
    raise BadRequestError.new 'identity id was missing'   if params[:id].blank?
    character = Fundamental::Character.find(params[:id])

    properties = params[:data] || nil
    if (!params[:new_attribute_name].blank? && !params[:new_attribute_value].blank?)
      properties ||= {}
      properties[params[:new_attribute_name]] = params[:new_attribute_value]
    end
    
    if !properties.nil?
      properties.delete_if { |k,v| v.blank? }
    end
    
    if !properties.nil? && properties.length == 0
      properties = nil
    end

    ip_access = IdentityProvider::Access.new(
      identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
      game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
      scopes: ['5dentity'],
    )
    response = ip_access.change_character_property(character.identifier, properties)

    respond_to do |format|
      if response.code == 200 || response.code == 201
        format.html { redirect_to fundamental_persistent_character_property_path(character.id), notice: 'Character Property was successfully updated.' }
      else
        format.html { redirect_to fundamental_persistent_character_property_path(character.id), notice: 'Character Property could not be updated.' }
      end
    end
  end

  
end
