class Military::ArmiesController < ApplicationController
  # GET /military/armies
  # GET /military/armies.json
  def index

    if params.has_key?(:region_id)  
      @map_region = Map::Region.find(params[:region_id])
      raise NotFoundError.new('Page Not Found') if @map_region.nil?
      @military_armies = @map_region.armies 
    elsif params.has_key?(:location_id)  
      @map_location = Map::Location.find(params[:location_id])
      raise NotFoundError.new('Page Not Found') if @map_location.nil?
      @military_armies = @map_location.armies
    end   

    respond_to do |format|
      
      format.html do
        if @military_armies.nil?
          @military_armies =  Military::Army.paginate(:page => params[:page], :per_page => 50)    
          @paginate = true   
        end 
      end
      
      format.json do
        if @military_armies.nil?  
          raise ForbiddenError.new('Access Forbidden')        
        end        
        render json: @military_armies
      end
    end
  end

  # GET /military/armies/1
  # GET /military/armies/1.json
  def show
    @military_army = Military::Army.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @military_army }
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

    respond_to do |format|
      if @military_army.update_attributes(params[:military_army])
        format.html { redirect_to @military_army, notice: 'Army was successfully updated.' }
        format.json { head :ok }
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
