class Fundamental::ArtifactsController < ApplicationController
  layout 'fundamental'
  
  before_filter :authenticate
  before_filter :deny_api, :except => [:show, :index]

  # GET /fundamental/artifacts
  # GET /fundamental/artifacts.json
  def index
    @fundamental_artifacts = Fundamental::Artifact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fundamental_artifacts }
    end
  end

  # GET /fundamental/artifacts/1
  # GET /fundamental/artifacts/1.json
  def show
    @fundamental_artifact = Fundamental::Artifact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_artifact }
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
