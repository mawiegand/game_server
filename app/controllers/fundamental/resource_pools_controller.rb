class Fundamental::ResourcePoolsController < ApplicationController
  # GET /fundamental/resource_pools
  # GET /fundamental/resource_pools.json
  def index
    @fundamental_resource_pools = Fundamental::ResourcePool.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fundamental_resource_pools }
    end
  end

  # GET /fundamental/resource_pools/1
  # GET /fundamental/resource_pools/1.json
  def show
    @fundamental_resource_pool = Fundamental::ResourcePool.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_resource_pool }
    end
  end

  # GET /fundamental/resource_pools/new
  # GET /fundamental/resource_pools/new.json
  def new
    @fundamental_resource_pool = Fundamental::ResourcePool.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_resource_pool }
    end
  end

  # GET /fundamental/resource_pools/1/edit
  def edit
    @fundamental_resource_pool = Fundamental::ResourcePool.find(params[:id])
  end

  # POST /fundamental/resource_pools
  # POST /fundamental/resource_pools.json
  def create
    @fundamental_resource_pool = Fundamental::ResourcePool.new(params[:fundamental_resource_pool])

    respond_to do |format|
      if @fundamental_resource_pool.save
        format.html { redirect_to @fundamental_resource_pool, notice: 'Resource pool was successfully created.' }
        format.json { render json: @fundamental_resource_pool, status: :created, location: @fundamental_resource_pool }
      else
        format.html { render action: "new" }
        format.json { render json: @fundamental_resource_pool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundamental/resource_pools/1
  # PUT /fundamental/resource_pools/1.json
  def update
    @fundamental_resource_pool = Fundamental::ResourcePool.find(params[:id])

    respond_to do |format|
      if @fundamental_resource_pool.update_attributes(params[:fundamental_resource_pool])
        format.html { redirect_to @fundamental_resource_pool, notice: 'Resource pool was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_resource_pool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/resource_pools/1
  # DELETE /fundamental/resource_pools/1.json
  def destroy
    @fundamental_resource_pool = Fundamental::ResourcePool.find(params[:id])
    @fundamental_resource_pool.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_resource_pools_url }
      format.json { head :ok }
    end
  end
end
