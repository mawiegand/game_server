class Fundamental::TreasuresController < ApplicationController
  layout 'fundamental'

  before_filter :authenticate
  before_filter :deny_api, :except => [:show, :index]

  # GET /fundamental/treasures
  # GET /fundamental/treasures.json
  def index
    last_modified = nil

    if params.has_key?(:region_id)
      @map_region = Map::Region.find(params[:region_id])
      raise NotFoundError.new('Region Not Found') if @map_region.nil?
      @fundamental_treasures = @map_region.treasures.visible_to_character(current_character)
      #last_modified =  @map_region.treasures_changed_at
    elsif params.has_key?(:location_id)
      @map_location = Map::Location.find(params[:location_id])
      raise NotFoundError.new('Location Not Found') if @map_location.nil?
      @fundamental_treasures = @map_location.treasures.visible_to_character(current_character)
      #last_modified =  @map_location.treasures_changed_at
    else
      @asked_for_index = true
      @fundamental_treasures = Fundamental::Treasure.visible_to_character(current_character).order('id asc')
    end

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          @fundamental_treasures = Fundamental::Treasure.order('id asc')
        end
        format.json do
          @fundamental_treasures = [] if @fundamental_treasures.nil?
          render(json: @fundamental_treasures)
        end
      end
    end
  end

  # GET /fundamental/treasures/1
  # GET /fundamental/treasures/1.json
  def show
    @fundamental_treasure = Fundamental::Treasure.find(params[:id])
    raise NotFoundError.new('Treasure Not Found') if !@fundamental_treasure.is_poacher_treasure_of?(current_character) && api_request?

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_treasure }
    end
  end

  # GET /fundamental/treasures/new
  # GET /fundamental/treasures/new.json
  def new
    @fundamental_treasure = Fundamental::Treasure.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_treasure }
    end
  end

  # GET /fundamental/treasures/1/edit
  def edit
    @fundamental_treasure = Fundamental::Treasure.find(params[:id])
  end

  # POST /fundamental/treasures
  # POST /fundamental/treasures.json
  def create
    @fundamental_treasure = Fundamental::Treasure.new(params[:fundamental_treasure])

    respond_to do |format|
      if @fundamental_treasure.save
        format.html { redirect_to @fundamental_treasure, notice: 'Treasure was successfully created.' }
        format.json { render json: @fundamental_treasure, status: :created, location: @fundamental_treasure }
      else
        format.html { render action: "new" }
        format.json { render json: @fundamental_treasure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundamental/treasures/1
  # PUT /fundamental/treasures/1.json
  def update
    @fundamental_treasure = Fundamental::Treasure.find(params[:id])

    respond_to do |format|
      if @fundamental_treasure.update_attributes(params[:fundamental_treasure])
        format.html { redirect_to @fundamental_treasure, notice: 'Treasure was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_treasure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/treasures/1
  # DELETE /fundamental/treasures/1.json
  def destroy
    @fundamental_treasure = Fundamental::Treasure.find(params[:id])
    @fundamental_treasure.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_treasures_url }
      format.json { head :ok }
    end
  end
end
