class Effect::ExperienceEffectsController < ApplicationController
  layout 'effect'

  before_filter :authenticate
  before_filter :deny_api, :except => [:index]

  # GET /effect/experience_effects
  # GET /effect/experience_effects.json
  def index
    if params.has_key?(:character_id)
      character = Fundamental::Character.find(params[:character_id])
      raise NotFoundError.new('Page Not Found') if character.nil?
      raise ForbiddenError.new('Access Forbidden') if !admin? && !staff? && !developer? && character != current_character
      @effect_resource_effects = character.experience_effects
    else
      @asked_for_index = true
    end

    respond_to do |format|
      format.html do
        if @effect_experience_effects.nil?
          @effect_experience_effects = Effect::ExperienceEffect.paginate(:page => params[:page], :per_page => 50)
          @paginate = true
        end
      end
      format.json do
        raise ForbiddenError.new('Access Forbidden') if @asked_for_index
        render json: @effect_experience_effects
      end
    end
  end

  # GET /effect/experience_effects/1
  # GET /effect/experience_effects/1.json
  def show
    @effect_experience_effect = Effect::ExperienceEffect.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @effect_experience_effect }
    end
  end

  # GET /effect/experience_effects/new
  # GET /effect/experience_effects/new.json
  def new
    @effect_experience_effect = Effect::ExperienceEffect.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @effect_experience_effect }
    end
  end

  # GET /effect/experience_effects/1/edit
  def edit
    @effect_experience_effect = Effect::ExperienceEffect.find(params[:id])
  end

  # POST /effect/experience_effects
  # POST /effect/experience_effects.json
  def create
    @effect_experience_effect = Effect::ExperienceEffect.new(params[:effect_experience_effect])

    respond_to do |format|
      if @effect_experience_effect.save
        format.html { redirect_to @effect_experience_effect, notice: 'Experience effect was successfully created.' }
        format.json { render json: @effect_experience_effect, status: :created, location: @effect_experience_effect }
      else
        format.html { render action: "new" }
        format.json { render json: @effect_experience_effect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /effect/experience_effects/1
  # PUT /effect/experience_effects/1.json
  def update
    @effect_experience_effect = Effect::ExperienceEffect.find(params[:id])

    respond_to do |format|
      if @effect_experience_effect.update_attributes(params[:effect_experience_effect])
        format.html { redirect_to @effect_experience_effect, notice: 'Experience effect was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @effect_experience_effect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /effect/experience_effects/1
  # DELETE /effect/experience_effects/1.json
  def destroy
    @effect_experience_effect = Effect::ExperienceEffect.find(params[:id])
    @effect_experience_effect.destroy

    respond_to do |format|
      format.html { redirect_to effect_experience_effects_url }
      format.json { head :ok }
    end
  end
end
