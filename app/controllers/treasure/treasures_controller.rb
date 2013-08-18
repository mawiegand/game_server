require 'geo_server/access'

class Treasure::TreasuresController < ApplicationController
  
  layout 'treasure'
  
  before_filter :authenticate
  before_filter :deny_api, :except => [:show, :create, :index]

  # GET /treasure/treasures
  # GET /treasure/treasures.json
  def index
    
    if params.has_key?(:geo_treasure_id)
      @treasure_treasures = Treasure::Treasure.where(geo_treasure_id: params[:geo_treasure_id])
    else
      raise ForbiddenError.new "access forbidden"  unless admin? || staff? || developer?
      @treasure_treasures = Treasure::Treasure.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @treasure_treasures }
    end
  end

  # GET /treasure/treasures/1
  # GET /treasure/treasures/1.json
  def show
    @treasure_treasure = Treasure::Treasure.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @treasure_treasure }
    end
  end

  # GET /treasure/treasures/new
  # GET /treasure/treasures/new.json
  def new
    @treasure_treasure = Treasure::Treasure.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @treasure_treasure }
    end
  end

  # GET /treasure/treasures/1/edit
  def edit
    @treasure_treasure = Treasure::Treasure.find(params[:id])
  end

  # POST /treasure/treasures
  # POST /treasure/treasures.json
  def create
    if params.has_key?(:geo_treasure_id)
      
      geo_treasure_id = params[:geo_tresure_id]
      
      raise BadRequestError.new('no current character') if current_character.nil?

      geo_server = GeoServer::Access.new({auth_token: request_access_token.token})
      geo_treasure = geo_server.get_treasure(geo_treasure_id) # todo fetch geotreasure!
      
      raise NotFoundError.new "treasure could not be found"  if geo_treasure.nil?

      response = geo_server.open_treasure(geo_treasure_id, current_character)
      if response.code == 200 || response.code == 203
        @treasure_treasure = Treasure::Treasure.new({
          geo_treasure_id: geo_treasure_id,
          level:           geo_treasure['level'],
          difficulty:      geo_treasure['difficulty'],
          category:        geo_treasure['category'],
          character_id:    current_character.id,
        })
      elsif response.code == 404
        raise NotFoundError.new  "treasure could not be found"
      elsif response.code == 409
        raise ConflictError.new  "treasure already claimed by another character"
      elsif response.code == 403
        raise ForbiddenError.new  "access forbidden"
      else 
        raise BadRequestError.new "bad request"
      end
      
    elsif admin? || staff? || developer?
      @treasure_treasure = Treasure::Treasure.new(params[:treasure_treasure])
    else
      raise ForbiddenError.new "access forbidden"
    end

    respond_to do |format|
      if @treasure_treasure.save
        format.html { redirect_to @treasure_treasure, notice: 'Treasure was successfully created.' }
        format.json { render json: @treasure_treasure, status: :created, location: @treasure_treasure }
      else
        format.html { render action: "new" }
        format.json { render json: @treasure_treasure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /treasure/treasures/1
  # PUT /treasure/treasures/1.json
  def update
    @treasure_treasure = Treasure::Treasure.find(params[:id])

    respond_to do |format|
      if @treasure_treasure.update_attributes(params[:treasure_treasure])
        format.html { redirect_to @treasure_treasure, notice: 'Treasure was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @treasure_treasure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /treasure/treasures/1
  # DELETE /treasure/treasures/1.json
  def destroy
    @treasure_treasure = Treasure::Treasure.find(params[:id])
    @treasure_treasure.destroy

    respond_to do |format|
      format.html { redirect_to treasure_treasures_url }
      format.json { head :ok }
    end
  end
end
