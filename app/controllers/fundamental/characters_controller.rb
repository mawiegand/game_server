require 'httparty'
require 'identity_provider/access'
require 'geo_server/geo_ip'
require 'credit_shop'

class Fundamental::CharactersController < ApplicationController
  layout 'fundamental'
  
#  before_filter :authenticate, :except => [:show, :self]   # presently, show must be excluded to be able to fetch self on startup (because safari looses auth-header on redirect from self to show)
  before_filter :deny_api,     :except => [:show, :index, :self]
  
  include Fundamental::CharactersHelper
  
  def index

    last_modified = nil 
    role = :default # assume lowest possible authorization

    if params.has_key?(:alliance_id)  
      @alliance = Fundamental::Alliance.find(params[:alliance_id])
      raise NotFoundError.new('Page Not Found') if @alliance.nil?
      @fundamental_characters = @alliance.members
      # todo -> determine last_modified
    else 
      @asked_for_index = true
    end   

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          raise ForbiddenError.new('Access forbidden.') unless (admin? || staff? || developer?) 
          if @fundamental_characters.nil?
            @fundamental_characters =  Fundamental::Character.paginate(:order => 'name', :page => params[:page], :per_page => 50)    
            @paginate = true   
          end 
        end
        format.json do
          if @asked_for_index 
            raise ForbiddenError.new('Access Forbidden')        
          end  
          @fundamental_characters = [] if @fundamental_characters.nil?  # necessary? or ok to send 'null' ?
          sanitized = @fundamental_characters.map do |character| 
            role = determine_access_role(character.id, character.alliance_id)
            logger.debug "Access with ROLE: #{ role }"
            include_root(character.serializable_hash(:role => role), :character)
          end
          render json: sanitized
        end
      end
    end
  end

  def self
    external_referer = request.env["HTTP_X_ALT_REFERER"] || params[:referer]
    request_url = request.env["HTTP_X_ALT_REQUEST"]
    
    if !current_character && request_access_token &&  request_access_token.valid? &&
        request_access_token.in_scope?(GAME_SERVER_CONFIG['scope']) && 
        !request_access_token.identifier.blank? &&
        request_authorization && request_authorization[:grant_type] == :bearer &&
        params.has_key?(:create_if_new)

      identity_provider_access = IdentityProvider::Access.new({
        identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
        game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
        scopes:                     ['5dentity'],
      })

      response = identity_provider_access.fetch_identity(request_access_token.identifier)
      logger.info "IDENTITY RESPONSE #{ response.blank? ? 'BLANK' : response.inspect }."
      identity = {}
      if response.code == 200
        identity = response.parsed_response
      end

      character_name = identity['nickname'] || GAME_SERVER_CONFIG['default_character_name'] || 'Player'

      # set character properties to default values
      start_resource_modificator = 1.0
      start_resource_bonuses = []
      start_xp_bonuses = []
      
      # fetch persistent character properties from identity provider  
      response = identity_provider_access.fetch_identity_properties(request_access_token.identifier)
      logger.info "START RESPONSE #{ response.blank? ? 'BLANK' : response.inspect }."
      
      if response.code == 200
        properties = response.parsed_response
        logger.info "START PROPERTIES #{ properties.blank? ? 'BLANK' : properties.inspect }."

        unless properties.empty?
          properties.each do |character_property|
            if !character_property.nil? && !character_property['data'].blank?
              unless character_property['data']['start_resource_modificator'].blank?
                property_value = character_property['data']['start_resource_modificator'].to_f
                logger.info "START PROPERTY_VALUE #{ property_value }."
                start_resource_modificator = property_value if property_value > 0
                logger.info "START RESOURCE MODIFICATOR #{ start_resource_modificator }."
              end
              unless character_property['data']['start_resource_bonus'].blank?
                start_resource_bonuses << character_property['data']['start_resource_bonus'].to_json # start_resource_bonus is saved as serialized hash, not as string
                logger.info "START RESOURCE BONUS #{ start_resource_bonuses.inspect }."
              end
              unless character_property['data']['start_xp_bonus'].blank?
                start_xp_bonuses << character_property['data']['start_xp_bonus'].to_json # start_resource_bonus is saved as serialized hash, not as string
                logger.info "START XP BONUS #{ start_xp_bonuses.inspect }."
              end
            end
          end
        end
      end

      logger.info "START RESOURCE MODIFICATOR FINAL #{ start_resource_modificator }."
      
      start_location = nil
      if params.has_key?(:player_invitation)
        start_location = Map::Location.location_for_player_invitation(params[:player_invitation])
      elsif params.has_key?(:alliance_invitation)
        start_location = Map::Location.location_for_alliance_invitation(params[:alliance_invitation])



      # disabled fetching geo coords for ip

      #else
      #  logger.debug "-----> fetch_coords_for_ip #{request.remote_ip}"
      #  geo_coords = GeoServer::GeoIp.fetch_coords_for_ip(request.remote_ip)
      #  logger.debug "-----> geo_coords #{geo_coords}"
      #  start_location = Map::Location.location_with_geo_coords(geo_coords) unless geo_coords.nil?
      #  logger.debug "-----> start_location #{start_location}"


      end
      
      character = Fundamental::Character.create_new_character(request_access_token.identifier, character_name, start_resource_modificator, false, start_location)
      raise InternalServerError.new('Could not create Character for new User.') if character.blank?     
                    
      Backend::SignInLogEntry.create({
        direct_referer_url: request.referer,
        referer_url:        external_referer,
        request_url:        request_url,
        character_id:       character.id,
        remote_ip:          request.remote_ip,
        sign_up:            true,
      })

      if !identity['platinum_lifetime_since'].nil? && Time.parse(identity['platinum_lifetime_since']) < Time.now
        character.set_platinum_lifetime
      end

      if !identity['supporter_since'].nil? && Time.parse(identity['supporter_since']) < Time.now
        character.supporter = true
      end

      character.insider_since = identity['insider_since']
      character.first_round = identity['created_at'].nil? ? false : Time.parse(identity['created_at']) > Time.now.advance(:hours => -1)
      character.lang = I18n.locale || "en"
      character.last_login_at = DateTime.now
      character.increment(:login_count)
      character.save
      
      if params.has_key?(:client_id)   # fetch gift
        response = identity_provider_access.fetch_signup_gift(request_access_token.identifier, params[:client_id])
        logger.info "START RESPONSE #{ response.blank? ? 'BLANK' : response.inspect }."
      
        if response.code == 200
          gifts = response.parsed_response
          logger.info "START PROPERTIES #{ properties.blank? ? 'BLANK' : properties.inspect }."

          unless gifts.nil? || gifts.empty?
            signup_gift = gifts[0]
            if !signup_gift.nil? && !signup_gift['data'].blank?
              character.redeem_startup_gift(signup_gift['data'])
            end
          end
        end
      end

      start_resource_bonuses.each do |start_resource_bonus|
        character.redeem_startup_gift(start_resource_bonus)
      end

      start_xp_bonuses.each do |start_xp_bonus|
        character.redeem_xp_start_bonus(start_xp_bonus)
      end

      if params.has_key?(:alliance_invitation)
        alliance = Fundamental::Alliance.find_by_invitation_code(params[:alliance_invitation])
        if !alliance.nil? && !alliance.full?
          alliance.add_character(character)
        end
      end

      redirect_to fundamental_character_path(character.id)
      
    elsif !current_character
      raise NotFoundError.new("Could not find user's character.")
    elsif current_character.deleted_from_game?
      
      # set player back to game
      current_character.deleted_from_game = false
      
      identity_provider_access = IdentityProvider::Access.new({
        identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
        game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
        scopes:                     ['5dentity'],
      })
      
      # set character properties to default values
      start_resource_modificator = 1.0
      start_resource_bonuses = []
      start_xp_bonuses = []

      # fetch persistent character properties from identity provider
      response = identity_provider_access.fetch_identity_properties(request_access_token.identifier)
      logger.info "START RESPONSE #{ response.blank? ? 'BLANK' : response.inspect }."
      
      if response.code == 200
        properties = response.parsed_response
        logger.info "START PROPERTIES #{ properties.blank? ? 'BLANK' : properties.inspect }."

        unless properties.empty?
          properties.each do |character_property|
            if !character_property.nil? && !character_property['data'].blank?
              unless character_property['data']['start_resource_modificator'].blank?
                property_value = character_property['data']['start_resource_modificator'].to_f
                logger.info "START PROPERTY_VALUE #{ property_value }."
                start_resource_modificator = property_value if property_value > 0
                logger.info "START RESOURCE MODIFICATOR #{ start_resource_modificator }."
              end
              unless character_property['data']['start_resource_bonus'].blank?
                start_resource_bonuses << character_property['data']['start_resource_bonus'].to_json # start_resource_bonus is saved as serialized hash, not as string
                logger.info "START RESOURCE BONUS #{ start_resource_bonuses.inspect }."
              end
              unless character_property['data']['start_xp_bonus'].blank?
                start_xp_bonuses << character_property['data']['start_xp_bonus'].to_json # start_resource_bonus is saved as serialized hash, not as string
                logger.info "START XP BONUS #{ start_xp_bonuses.inspect }."
              end
            end
          end
        end
      end

      logger.info "START RESOURCE MODIFICATOR FINAL #{ start_resource_modificator }."
      
      if !current_character.save
        # raise InternalServerError.new('Could not create new character.') 
      end
  
      current_character.create_resource_pool
      
      # raise InternalServerError.new('Could not save the base of the character.')  if !current_character.save
  
      current_character.create_ranking({
        character_name: current_character.name,
      })
      
      location = Map::Location.find_empty
      if !location || !current_character.claim_location(location)
        raise InternalServerError.new('Could not claim an empty location.')
      end

      Settlement::Settlement.create_settlement_at_location(location, 2, current_character)  # 2: home base
        
      current_character.base_location_id = location.id              # TODO is this the home_location_id?
      current_character.base_region_id = location.region_id
      current_character.base_node_id = location.region.node_id

      current_character.resource_pool.fill_with_start_resources_transaction(start_resource_modificator)
      
      current_character.create_tutorial_state
      current_character.tutorial_state.create_start_quest_state     
            
      Backend::SignInLogEntry.create({
        direct_referer_url: request.referer,
        referer_url:        external_referer,
        request_url:        request_url,
        character_id:       current_character.id,
        remote_ip:          request.remote_ip,
      })
      
      current_character.last_login_at = DateTime.now
      current_character.increment(:login_count)
      
      current_character.check_consistency
      current_character.save
      
      redirect_to fundamental_character_path(current_character.id)
    else
      current_character.last_login_at = DateTime.now
      current_character.increment(:login_count)
      current_character.save
      
      Backend::SignInLogEntry.create({
        direct_referer_url: request.referer,
        referer_url:        external_referer,
        request_url:        request_url,
        character_id:       current_character.id,
        remote_ip:          request.remote_ip,
      })
      
      redirect_to fundamental_character_path(current_character_id)
    end
  end

  # GET /fundamental/characters/1
  # GET /fundamental/characters/1.json
  def show
    @fundamental_character = Fundamental::Character.find(params[:id])
    role = determine_access_role(@fundamental_character.id, @fundamental_character.alliance_id) || :default
    
    if admin? && backend_request?
      account_response = CreditShop::BytroShop.get_customer_account(@fundamental_character.identifier)
      @credit_amount = account_response[:response_data][:amount]
      @shop_credit_transaction = Shop::CreditTransaction.new({partner_user_id: @fundamental_character.identifier})
    end
    
    if stale?(:last_modified => @fundamental_character.updated_at.utc, :etag => @fundamental_character)
      respond_to do |format|
        format.html do
          raise ForbiddenError.new "Unauthorized access. Incident logged." unless signed_in_to_backend? && (role == :staff || role == :admin || role == :developer)
        end
        format.json do
          render json: @fundamental_character, :role => role
        end
      end
    end
  end

  # GET /fundamental/characters/new
  # GET /fundamental/characters/new.json
  def new
    @fundamental_character = Fundamental::Character.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_character }
    end
  end

  # GET /fundamental/characters/1/edit
  def edit
    @fundamental_character = Fundamental::Character.find(params[:id])
  end

  # POST /fundamental/characters
  # POST /fundamental/characters.json
  def create
    @fundamental_character = Fundamental::Character.new(params[:fundamental_character])

    respond_to do |format|
      if @fundamental_character.save
        format.html { redirect_to @fundamental_character, notice: 'Character was successfully created.' }
        format.json { render json: @fundamental_character, status: :created, location: @fundamental_character }
      else
        format.html { render action: "new" }
        format.json { render json: @fundamental_character.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundamental/characters/1
  # PUT /fundamental/characters/1.json
  def update
    @fundamental_character = Fundamental::Character.find(params[:id])

    respond_to do |format|
      if @fundamental_character.update_attributes(params[:fundamental_character])
        format.html { redirect_to @fundamental_character, notice: 'Character was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_character.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/characters/1
  # DELETE /fundamental/characters/1.json
  def destroy
    @fundamental_character = Fundamental::Character.find(params[:id])
    @fundamental_character.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_characters_url }
      format.json { head :ok }
    end
  end
end
