class Map::RegionsController < ApplicationController
  layout 'map'
  
  
  # GET /map/regions
  def index

    respond_to do |format|
      format.html do
        if params.has_key?(:node_id)  
          @map_node = Map::Node.find_by_address(params[:node_id])
          raise NotFoundError.new('Page Not Found') if @map_node.nil?
          @map_regions = @map_node.region.nil? ? [] : [ @map_node.region ]
        else
          @map_regions =  Map::Region.paginate(:page => params[:page], :per_page => 64)    
          @paginate = true    
        end
      end
      format.json do
        if params.has_key?(:node_id)  
          @map_node = Map::Node.find_by_address(params[:node_id])
          raise NotFoundError.new('Page Not Found') if @map_node.nil?
          @map_regions = @map_node.region.nil? ? [] : [ @map_node.region ]
        else
          raise ForbiddenError.new('Access Forbidden')        
        end        
        render json: @map_regions
      end
    end
  end

  # GET /map/regions/1
  # GET /map/regions/1.json
  def show
    @map_region = Map::Region.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @map_region }
    end
  end

  # GET /map/regions/new
  # GET /map/regions/new.json
  def new
    @map_region = Map::Region.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @map_region }
    end
  end

  # GET /map/regions/1/edit
  def edit
    @map_region = Map::Region.find(params[:id])
  end

  # POST /map/regions
  # POST /map/regions.json
  def create
    @map_region = Map::Region.new(params[:map_region])

    respond_to do |format|
      if @map_region.save
        format.html { redirect_to @map_region, notice: 'Region was successfully created.' }
        format.json { render json: @map_region, status: :created, location: @map_region }
      else
        format.html { render action: "new" }
        format.json { render json: @map_region.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /map/regions/1
  # PUT /map/regions/1.json
  def update
    @map_region = Map::Region.find(params[:id])

    respond_to do |format|
      if @map_region.update_attributes(params[:map_region])
        format.html { redirect_to @map_region, notice: 'Region was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @map_region.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /map/regions/1
  # DELETE /map/regions/1.json
  def destroy
    @map_region = Map::Region.find(params[:id])
    @map_region.destroy

    respond_to do |format|
      format.html { redirect_to map_regions_url }
      format.json { head :ok }
    end
  end
end
