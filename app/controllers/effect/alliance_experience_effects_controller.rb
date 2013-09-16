class Effect::AllianceExperienceEffectsController < ApplicationController
  layout 'effect'

  before_filter :authenticate
  before_filter :deny_api, :except => [:index]

  # GET /effect/alliance_experience_effects
  # GET /effect/alliance_experience_effects.json
  def index
    if params.has_key?(:alliance_id)
      alliance = Fundamental::Alliance.find(params[:alliance_id])
      raise NotFoundError.new('Page Not Found') if alliance.nil?
      raise ForbiddenError.new('Access Forbidden') if !admin? && !staff? && !developer? && alliance != current_character.alliance
      @effect_alliance_experience_effects = alliance.experience_effects
      #last_modified = pool.updated_at
    else
      @asked_for_index = true
    end

    #render_not_modified_or(last_modified) do
    respond_to do |format|
      format.html do
        if @effect_alliance_construction_effects.nil?
          @effect_alliance_construction_effects = Effect::AllianceConstructionEffect.paginate(:page => params[:page], :per_page => 50)
          @paginate = true
        end
      end
      format.json do
        raise ForbiddenError.new('Access Forbidden') if @asked_for_index
        render json: @effect_alliance_construction_effects
      end
    end


    @effect_alliance_experience_effects = Effect::AllianceExperienceEffect.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @effect_alliance_experience_effects }
    end
  end

  # GET /effect/alliance_experience_effects/1
  # GET /effect/alliance_experience_effects/1.json
  def show
    @effect_alliance_experience_effect = Effect::AllianceExperienceEffect.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @effect_alliance_experience_effect }
    end
  end

  # GET /effect/alliance_experience_effects/new
  # GET /effect/alliance_experience_effects/new.json
  def new
    @effect_alliance_experience_effect = Effect::AllianceExperienceEffect.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @effect_alliance_experience_effect }
    end
  end

  # GET /effect/alliance_experience_effects/1/edit
  def edit
    @effect_alliance_experience_effect = Effect::AllianceExperienceEffect.find(params[:id])
  end

  # POST /effect/alliance_experience_effects
  # POST /effect/alliance_experience_effects.json
  def create
    @effect_alliance_experience_effect = Effect::AllianceExperienceEffect.new(params[:effect_alliance_experience_effect])

    respond_to do |format|
      if @effect_alliance_experience_effect.save
        format.html { redirect_to @effect_alliance_experience_effect, notice: 'Alliance experience effect was successfully created.' }
        format.json { render json: @effect_alliance_experience_effect, status: :created, location: @effect_alliance_experience_effect }
      else
        format.html { render action: "new" }
        format.json { render json: @effect_alliance_experience_effect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /effect/alliance_experience_effects/1
  # PUT /effect/alliance_experience_effects/1.json
  def update
    @effect_alliance_experience_effect = Effect::AllianceExperienceEffect.find(params[:id])

    respond_to do |format|
      if @effect_alliance_experience_effect.update_attributes(params[:effect_alliance_experience_effect])
        format.html { redirect_to @effect_alliance_experience_effect, notice: 'Alliance experience effect was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @effect_alliance_experience_effect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /effect/alliance_experience_effects/1
  # DELETE /effect/alliance_experience_effects/1.json
  def destroy
    @effect_alliance_experience_effect = Effect::AllianceExperienceEffect.find(params[:id])
    @effect_alliance_experience_effect.destroy

    respond_to do |format|
      format.html { redirect_to effect_alliance_experience_effects_url }
      format.json { head :ok }
    end
  end
end
