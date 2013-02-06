class Fundamental::ArtifactInitiationsController < ApplicationController
  layout 'fundamental'

  before_filter :authenticate
  before_filter :deny_api, :except => [:create]

  # GET /fundamental/artifact_initiations
  # GET /fundamental/artifact_initiations.json
  def index
    @fundamental_artifact_initiations = Fundamental::ArtifactInitiation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fundamental_artifact_initiations }
    end
  end

  # GET /fundamental/artifact_initiations/1
  # GET /fundamental/artifact_initiations/1.json
  def show
    @fundamental_artifact_initiation = Fundamental::ArtifactInitiation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_artifact_initiation }
    end
  end

  # GET /fundamental/artifact_initiations/new
  # GET /fundamental/artifact_initiations/new.json
  def new
    @fundamental_artifact_initiation = Fundamental::ArtifactInitiation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_artifact_initiation }
    end
  end

  # GET /fundamental/artifact_initiations/1/edit
  def edit
    @fundamental_artifact_initiation = Fundamental::ArtifactInitiation.find(params[:id])
  end

  # POST /fundamental/artifact_initiations
  # POST /fundamental/artifact_initiations.json
  def create
    @initiation = Fundamental::ArtifactInitiation.new(params[:fundamental_artifact_initiation])

    artifact = @initiation.artifact
    raise NotFoundError.new('artifact not found') if artifact.nil?

    settlement = artifact.settlement
    raise BadRequestError.new('artifact has no settlement') if settlement.nil?

    owner = artifact.owner
    raise BadRequestError.new('artifact has no owner') if owner.nil?

    raise BadRequestError.new('not owner of artifact') if owner != current_character

    # testen ob schon aktiviert
    raise BadRequestError.new('artifact already initiated') if artifact.initiated?

    # testen ob artefakt initiierung freigeschaltet
    if (settlement.artifact_initiation_level.nil? ||
        settlement.artifact_initiation_level < 1)
      raise BadRequestError.new('missing required building for artifact initiation')
    end

    costs = artifact.initiation_costs
    unless current_character.resource_pool.have_at_least_resources(costs)
      raise ForbiddenError.new('not enough resources to pay for initiation')
    end
    current_character.resource_pool.remove_resources_transaction(costs)

    # initiierung anlegen
    @initiation.started_at = Time.now
    @initiation.finished_at = @initiation.started_at + artifact.initiation_duration

    @initiation.create_ticker_event

    respond_to do |format|
      if @initiation.save
        format.html { redirect_to @initiation, notice: 'Artifact initiation was successfully created.' }
        format.json { render json: @initiation, status: :created, location: @initiation }
      else
        format.html { render action: "new" }
        format.json { render json: @initiation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundamental/artifact_initiations/1
  # PUT /fundamental/artifact_initiations/1.json
  def update
    @fundamental_artifact_initiation = Fundamental::ArtifactInitiation.find(params[:id])

    respond_to do |format|
      if @fundamental_artifact_initiation.update_attributes(params[:fundamental_artifact_initiation])
        format.html { redirect_to @fundamental_artifact_initiation, notice: 'Artifact initiation was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_artifact_initiation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/artifact_initiations/1
  # DELETE /fundamental/artifact_initiations/1.json
  def destroy
    @initiation = Fundamental::ArtifactInitiation.find(params[:id])

    @initiation.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_artifact_initiations_url }
      format.json { head :ok }
    end
  end
end
