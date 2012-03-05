class Map::NodesController < ApplicationController
  # GET /map/nodes
  # GET /map/nodes.json
  def index
    @map_nodes = Map::Node.paginate(:page => params[:page], :per_page => 64)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @map_nodes }
    end
  end

  # GET /map/nodes/1
  # GET /map/nodes/1.json
  def show
    
    if (params[:id] == 'root')
      @map_node = Map::Node.root
    elsif
      
    else
      @map_node = Map::Node.find(params[:id])
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @map_node }
    end
  end

  # GET /map/nodes/new
  # GET /map/nodes/new.json
  def new
    @map_node = Map::Node.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @map_node }
    end
  end

  # GET /map/nodes/1/edit
  def edit
    @map_node = Map::Node.find(params[:id])
  end

  # POST /map/nodes
  # POST /map/nodes.json
  def create
    @map_node = Map::Node.new(params[:map_node])

    respond_to do |format|
      if @map_node.save
        format.html { redirect_to @map_node, notice: 'Node was successfully created.' }
        format.json { render json: @map_node, status: :created, location: @map_node }
      else
        format.html { render action: "new" }
        format.json { render json: @map_node.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /map/nodes/1
  # PUT /map/nodes/1.json
  def update
    @map_node = Map::Node.find(params[:id])

    respond_to do |format|
      if @map_node.update_attributes(params[:map_node])
        format.html { redirect_to @map_node, notice: 'Node was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @map_node.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /map/nodes/1
  # DELETE /map/nodes/1.json
  def destroy
    @map_node = Map::Node.find(params[:id])
    @map_node.destroy

    respond_to do |format|
      format.html { redirect_to map_nodes_url }
      format.json { head :ok }
    end
  end
end
