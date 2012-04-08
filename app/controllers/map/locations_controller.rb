class Map::LocationsController < ApplicationController
  layout 'map'


  # GET /map/locations
  # GET /map/locations.json
  def index
    
    respond_to do |format|
      format.html do
        if params.has_key?(:region_id)  
          @map_region = Map::Region.find_by_id(params[:region_id])
          raise NotFoundError.new('Page Not Found') if @map_region.nil?
          @map_locations = @map_region.locations.nil? ? [] : @map_region.locations 
        else
          @map_locations =  Map::Location.paginate(:page => params[:page], :per_page => 64)    
          @paginate = true    
        end
      end
      format.json do
        if params.has_key?(:region_id)  
          @map_region = Map::Region.find_by_id(params[:region_id])
          raise NotFoundError.new('Page Not Found') if @map_region.nil?
          @map_locations = @map_region.locations.nil? ? [] : @map_region.locations 
        else
          raise ForbiddenError.new('Access Forbidden')        
        end        
        render json: @map_locations
      end
    end
  end

  # GET /map/locations/1
  # GET /map/locations/1.json
  def show
    if params.has_key?(:region_id)  
      @map_region = Map::Region.find_by_id(params[:region_id])
      raise NotFoundError.new('Page Not Found') if @map_region.nil?
      if params.has_key?(:slot) 
        @map_location = @map_region.locations.find_by_slot(params[:slot]) 
      else
        @map_location = @map_region.locations.find_by_id(params[:id]) 
      end
    else
      @map_location = Map::Location.find_by_id(params[:id])
    end
    
    raise NotFoundError if @map_location.nil?
    
    last_modified = nil 
    last_modified = @map_location.updated_at unless @map_location.nil?
        
    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html # show.html.erb
        format.json do 
          options = { :except => @map_location.attributes.delete_if { |k,v| !v.blank? }.keys }
          render :json => @map_location.to_json(options) 
        end
      end
    end
  end

  # GET /map/locations/new
  # GET /map/locations/new.json
  def new
    @map_location = Map::Location.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @map_location }
    end
  end

  # GET /map/locations/1/edit
  def edit
    @map_location = Map::Location.find(params[:id])
  end

  # POST /map/locations
  # POST /map/locations.json
  def create
    @map_location = Map::Location.new(params[:map_location])

    respond_to do |format|
      if @map_location.save
        format.html { redirect_to @map_location, notice: 'Location was successfully created.' }
        format.json { render json: @map_location, status: :created, location: @map_location }
      else
        format.html { render action: "new" }
        format.json { render json: @map_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /map/locations/1
  # PUT /map/locations/1.json
  def update
    @map_location = Map::Location.find(params[:id])

    respond_to do |format|
      if @map_location.update_attributes(params[:map_location])
        format.html { redirect_to @map_location, notice: 'Location was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @map_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /map/locations/1
  # DELETE /map/locations/1.json
  def destroy
    @map_location = Map::Location.find(params[:id])
    @map_location.destroy

    respond_to do |format|
      format.html { redirect_to map_locations_url }
      format.json { head :ok }
    end
  end
end
