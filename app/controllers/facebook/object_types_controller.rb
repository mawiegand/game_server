class Facebook::ObjectTypesController < ApplicationController
  # GET /facebook/object_types
  # GET /facebook/object_types.json
  def index
    @facebook_object_types = Facebook::ObjectType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @facebook_object_types }
    end
  end

  # GET /facebook/object_types/1
  # GET /facebook/object_types/1.json
  def show
    @facebook_object_type = Facebook::ObjectType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @facebook_object_type }
    end
  end

  # GET /facebook/object_types/new
  # GET /facebook/object_types/new.json
  def new
    @facebook_object_type = Facebook::ObjectType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @facebook_object_type }
    end
  end

  # GET /facebook/object_types/1/edit
  def edit
    @facebook_object_type = Facebook::ObjectType.find(params[:id])
  end

  # POST /facebook/object_types
  # POST /facebook/object_types.json
  def create
    @facebook_object_type = Facebook::ObjectType.new(params[:facebook_object_type])

    respond_to do |format|
      if @facebook_object_type.save
        format.html { redirect_to @facebook_object_type, notice: 'Object type was successfully created.' }
        format.json { render json: @facebook_object_type, status: :created, location: @facebook_object_type }
      else
        format.html { render action: "new" }
        format.json { render json: @facebook_object_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /facebook/object_types/1
  # PUT /facebook/object_types/1.json
  def update
    @facebook_object_type = Facebook::ObjectType.find(params[:id])

    respond_to do |format|
      if @facebook_object_type.update_attributes(params[:facebook_object_type])
        format.html { redirect_to @facebook_object_type, notice: 'Object type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @facebook_object_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facebook/object_types/1
  # DELETE /facebook/object_types/1.json
  def destroy
    @facebook_object_type = Facebook::ObjectType.find(params[:id])
    @facebook_object_type.destroy

    respond_to do |format|
      format.html { redirect_to facebook_object_types_url }
      format.json { head :ok }
    end
  end
end
