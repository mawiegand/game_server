class Fundamental::ArtifactsController < ApplicationController
  layout 'fundamental'
  
  before_filter :authenticate
  before_filter :deny_api, :except => [:show, :index]

  # GET /fundamental/artifacts
  # GET /fundamental/artifacts.json
  def index
    last_modified = nil

    if params.has_key?(:region_id)
      @map_region = Map::Region.find(params[:region_id])
      raise NotFoundError.new('Region Not Found') if @map_region.nil?
      @fundamental_artifacts = @map_region.artifacts.visible
      #last_modified =  @map_region.artifacts_changed_at
    elsif params.has_key?(:location_id)
      @map_location = Map::Location.find(params[:location_id])
      raise NotFoundError.new('Location Not Found') if @map_location.nil?
      if !@map_location.artifact.nil? && @map_location.artifact.visible?
        @fundamental_artifacts = @map_location.artifact
      else
        @fundamental_artifacts = nil
      end
      #last_modified =  @map_location.artifacts_changed_at
    else
      @asked_for_index = true
      @fundamental_artifacts = Fundamental::Artifact.all
    end

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html # index.html.erb
        format.json do
          raise ForbiddenError.new('Access Forbidden') if @asked_for_index
          @fundamental_artifacts = [] if @fundamental_artifacts.nil?
          render(json: @fundamental_artifacts.to_json(:include => :initiation))
        end
      end
    end
  end

  # GET /fundamental/artifacts/1
  # GET /fundamental/artifacts/1.json
  def show
    if params.has_key?(:character_id)
      @character = Fundamental::Character.find(params[:character_id])
      raise NotFoundError.new('Page Not Found') if @character.nil?
      raise ForbiddenError.new('Access Forbidden') unless @character == current_character
      @fundamental_artifact = @character.artifact
      # todo -> determine last_modified
    else
      @fundamental_artifact = Fundamental::Artifact.find(params[:id])
      raise NotFoundError.new('Artifact Not Found') if !@fundamental_artifact.visible? && api_request?
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json do
        render(json: @fundamental_artifact.to_json(:include => :initiation))
      end
    end
  end

  # GET /fundamental/artifacts/new
  # GET /fundamental/artifacts/new.json
  def new
    @fundamental_artifact = Fundamental::Artifact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_artifact }
    end
  end

  # GET /fundamental/artifacts/1/edit
  def edit
    @fundamental_artifact = Fundamental::Artifact.find(params[:id])
  end

  # POST /fundamental/artifacts
  # POST /fundamental/artifacts.json
  def create
    @fundamental_artifact = Fundamental::Artifact.new(params[:fundamental_artifact])

    respond_to do |format|
      if @fundamental_artifact.save
        format.html { redirect_to @fundamental_artifact, notice: 'Artifact was successfully created.' }
        format.json { render json: @fundamental_artifact, status: :created, location: @fundamental_artifact }
      else
        format.html { render action: "new" }
        format.json { render json: @fundamental_artifact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundamental/artifacts/1
  # PUT /fundamental/artifacts/1.json
  def update
    @fundamental_artifact = Fundamental::Artifact.find(params[:id])

    respond_to do |format|
      if @fundamental_artifact.update_attributes(params[:fundamental_artifact])
        format.html { redirect_to @fundamental_artifact, notice: 'Artifact was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_artifact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/artifacts/1
  # DELETE /fundamental/artifacts/1.json
  def destroy
    @fundamental_artifact = Fundamental::Artifact.find(params[:id])
    @fundamental_artifact.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_artifacts_url }
      format.json { head :ok }
    end
  end
end
