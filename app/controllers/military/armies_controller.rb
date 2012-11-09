class Military::ArmiesController < ApplicationController
  layout 'military'

  before_filter :authenticate
  before_filter :deny_api,        :except => [:show, :index, :update]
  before_filter :authorize_staff, :except => [:show, :index, :update]

  @@short_fields = ApplicationController.expand_fields(
    Military::Army.new,
    [ :id, :name, :region_id, :location_id, :owner_id, :owner_name, :npc, :garrison,
      'unitcategory_',
      :alliance_id, :alliance_tag, :ap_present, :ap_max, :ap_next, :mode, :stance, :size_present, :size_max, 
      :strength, :battle_id, :rank, :target_region_id, :target_location_id, :target_reached_at, :updated_at, :suspension_ends_at]
  )
  @@aggregate_fields = [:id, :garrison, :owner_id, :alliance_id, :npc, :stance, :mode, :battle_id, :strength, :updated_at, :suspension_ends_at]
 
  # Returns a list of armies in a region or at a location. There are three 
  # modes to request the list for JSON:
  # - armies.json?aggregate: returns a very condensed list that only features
  #   the fields needed to calculate the aggregated army display for a region
  # - armies.json?short: returns a shortened list of the armies that contains
  #   the information needed to place the army on the map, but no detailed
  #   information that would be needed for a mouse-over or the detailed
  #   information.
  # - armies.json: returns a complete list with all the fields of all armies.
  #
  #  GET /map/regions/:region_id/armies
  #  GET /map/regions/:region_id/armies.json
  #  GET /map/locations/:location_id/armies
  #  GET /map/locations/:location_id/armies.json
  #  GET /military/armies
  def index

    last_modified = nil 

    if params.has_key?(:region_id)  
      @map_region = Map::Region.find(params[:region_id])
      raise NotFoundError.new('Page Not Found') if @map_region.nil?
      if params.has_key?(:fortress_only)
        @military_armies = @map_region.locations[0].armies
      else
        @military_armies = @map_region.armies 
      end
      last_modified =  @map_region.armies_changed_at
    elsif params.has_key?(:location_id)  
      @map_location = Map::Location.find(params[:location_id])
      raise NotFoundError.new('Page Not Found') if @map_location.nil?
      @military_armies = @map_location.armies
      last_modified =  @map_location.armies_changed_at
    elsif params.has_key?(:alliance_id)  
      @alliance = Fundamental::Alliance.find(params[:alliance_id])
      raise NotFoundError.new('Page Not Found') if @alliance.nil?
      @military_armies = @alliance.armies
      # todo -> determine last_modified
    elsif params.has_key?(:character_id)  
      @character = Fundamental::Character.find(params[:character_id])
      raise NotFoundError.new('Page Not Found') if @character.nil?
      @military_armies = @character.armies
      # todo -> determine last_modified
    elsif params.has_key?(:target_location_id)
      @military_armies = Military::Army.find_by_target_location_id(params[:target_location_id])
    else 
      @asked_for_index = true
    end   

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          if @military_armies.nil?
            @military_armies =  Military::Army.paginate(:page => params[:page], :per_page => 50)    
            @paginate = true   
          end 
        end
        format.json do
          raise ForbiddenError.new('Access Forbidden')   if @asked_for_index     
          @military_armies = [] if @military_armies.nil?  # necessary? or ok to send 'null' ?
          if params.has_key?(:short)
            render json: @military_armies.select { |army| !army.removed? }.map { |army| army.as_json(:only => @@short_fields,     :role => determine_access_role(army.owner_id, army.alliance_id)) }
          elsif params.has_key?(:aggregate)
            render json: @military_armies.select { |army| !army.removed? }.map { |army| army.as_json(:only => @@aggregate_fields, :role => determine_access_role(army.owner_id, army.alliance_id)) }         
          else
            render json: @military_armies.select { |army| !army.removed? }.map { |army| army.as_json(:role => determine_access_role(army.owner_id, army.alliance_id)) }
          end
        end
      end
    end
  end

  # Returns detailed information to the army with the given id. For JSON, 
  # there are two different modes of request:
  # - army.json?short: returns a shortened list of the armies that contains
  #   the information needed to place the army on the map, but no detailed
  #   information that would be needed for a mouse-over or the detailed
  #   information.
  # - army: returns a complete list with all the fields of all armies.
  #
  # GET /military/armies/1
  # GET /military/armies/1.json
  def show
    @military_army = Military::Army.find(params[:id])
    raise NotFoundError.new('Page Not Found') if @military_army.nil? || (@military_army.removed? && !staff?)

    last_modified =  @military_army.updated_at

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html # show.html.erb
        format.json do
          if params.has_key?(:short)
            render json: @military_army, :only => @@short_fields,     :role => determine_access_role(@military_army.owner_id, @military_army.alliance_id) 
          elsif params.has_key?(:aggregate)
            render json: @military_army, :only => @@aggregate_fields, :role => determine_access_role(@military_army.owner_id, @military_army.alliance_id)         
          else
            render json: @military_army, :role => determine_access_role(@military_army.owner_id, @military_army.alliance_id) 
          end 
        end
      end
    end
  end

  # GET /military/armies/new
  # GET /military/armies/new.json
  def new
    @military_army = Military::Army.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @military_army }
    end
  end

  # GET /military/armies/1/edit
  def edit
    @military_army = Military::Army.find(params[:id])
  end

  # POST /military/armies
  # POST /military/armies.json
  def create
    @military_army = Military::Army.new(params[:military_army])

    respond_to do |format|
      if @military_army.save
        format.html { redirect_to @military_army, notice: 'Army was successfully created.' }
        format.json { render json: @military_army, status: :created, location: @military_army }
      else
        format.html { render action: "new" }
        format.json { render json: @military_army.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /military/armies/1
  # PUT /military/armies/1.json
  def update
    @military_army = Military::Army.find(params[:id])

    role = determine_access_role(@military_army.owner_id, @military_army.alliance_id)    
    
    attributes_to_update = {}
    if role === :staff || role === :admin
      attributes_to_update = params[:military_army]
    elsif role === :owner
      attributes_to_update[:name] = params[:military_army][:name] unless params[:military_army][:name].blank?
      attributes_to_update[:stance] = params[:military_army][:stance] unless params[:military_army][:stance].blank?
    end

    raise ForbiddenError.new 'tried to update army properties that are forbidden to change for the role.' if attributes_to_update.nil?

    respond_to do |format|
      if @military_army.update_attributes(attributes_to_update)
        format.html { redirect_to @military_army, notice: 'Army was successfully updated.' }
        format.json { render json: true, status: :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @military_army.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /military/armies/1
  # DELETE /military/armies/1.json
  def destroy
    @military_army = Military::Army.find(params[:id])
    @military_army.destroy

    respond_to do |format|
      format.html { redirect_to military_armies_url }
      format.json { head :ok }
    end
  end

end
