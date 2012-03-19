class Map::NodesController < ApplicationController
  
  # TODO: define what's accessible by the API and what's accessible by the website (admin area)
  # TODO: define accessibility and readability of attributes (per role)
  # TODO: a few methods should need authentication (e.g. update (API) and all admin functions)
  
  # GET /map/nodes
  # TODO: block this for the API
  def index
    @map_nodes = Map::Node.paginate(:page => params[:page], :per_page => 64)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # Shows individual nodes. Does not need any authentication; the map structure is public and
  # therefore world-readable.
  # 
  # There are two possibilities for addressing nodes:
  # 1. by their id (auto_increment assigned on node creation) or
  # 2. by their quad-tree path (e.g. nodes/qt0101 translates to the forth-level node that 
  #    is the upper-left, upper-rigth, upper-left, upper-right child of the root node.
  #
  # The root node is a special node that can be accessed directly via "root".
  #
  #  GET /map/nodes/1           # html representation of the node with id 1
  #  GET /map/nodes/1.json      # json representation of the node with id 1
  #  GET /map/nodes/qt1         # the node at quad-tree path '1'
  #  GET /map/nodes/qt1.json    
  #  GET /map/nodes/root        # the root node (no parent, level 0)
  #  GET /map/nodes/root.json
  def show
    
    @map_node = Map::Node.find_by_address(params[:id])
    
    raise NotFoundError if @map_node.nil?
    
    last_modified = nil 
    last_modified = @map_node.updated_at unless @map_node.nil?
        
    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html # show.html.erb
        format.json { render :json => @map_node.to_json(:except => @map_node.attributes.delete_if { |k,v| !v.blank? }.keys ) }
      end
    end
  end

  # GET /map/nodes/new
  # TODO: block this for the API
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
  # TODO: block this for the API
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
  # TODO: block this for the API
  def destroy
    @map_node = Map::Node.find(params[:id])
    @map_node.destroy

    respond_to do |format|
      format.html { redirect_to map_nodes_url }
      format.json { head :ok }
    end
  end
end
