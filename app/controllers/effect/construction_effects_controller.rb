class Effect::ConstructionEffectsController < ApplicationController
  layout 'effect'
  
  before_filter :authenticate
  before_filter :deny_api, :except => [:index]


  # GET /effect/construction_effects
  # GET /effect/construction_effects.json
  def index
    last_modified = nil

    if params.has_key?(:character_id)
      character = Fundamental::Character.find_by_id(params[:character_id])
      raise NotFoundError.new('Page Not Found') if character.nil?
      raise ForbiddenError.new('Access Forbidden') if !admin? && !staff? && !developer? && params[:character_id] != current_character.id
      @effect_construction_effects = character.construction_effects
    else
      @asked_for_index = true
    end

    #render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          if @effect_construction_effects.nil?
            @effect_construction_effects = Effect::ConstructionEffect.paginate(:page => params[:page], :per_page => 50)
            @paginate = true
          end
        end
        format.json do
          raise ForbiddenError.new('Access Forbidden') if @asked_for_index
          render json: @effect_construction_effects
        end
      end
    #end    
  end

  # GET /effect/construction_effects/1
  # GET /effect/construction_effects/1.json
  def show
    @effect_construction_effect = Effect::ConstructionEffect.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @effect_construction_effect }
    end
  end

  # GET /effect/construction_effects/new
  # GET /effect/construction_effects/new.json
  def new
    @effect_construction_effect = Effect::ConstructionEffect.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @effect_construction_effect }
    end
  end

  # GET /effect/construction_effects/1/edit
  def edit
    @effect_construction_effect = Effect::ConstructionEffect.find(params[:id])
  end

  # POST /effect/construction_effects
  # POST /effect/construction_effects.json
  def create
    @effect_construction_effect = Effect::ConstructionEffect.new(params[:effect_construction_effect])

    respond_to do |format|
      if @effect_construction_effect.save
        format.html { redirect_to @effect_construction_effect, notice: 'Construction effect was successfully created.' }
        format.json { render json: @effect_construction_effect, status: :created, location: @effect_construction_effect }
      else
        format.html { render action: "new" }
        format.json { render json: @effect_construction_effect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /effect/construction_effects/1
  # PUT /effect/construction_effects/1.json
  def update
    @effect_construction_effect = Effect::ConstructionEffect.find(params[:id])

    respond_to do |format|
      if @effect_construction_effect.update_attributes(params[:effect_construction_effect])
        format.html { redirect_to @effect_construction_effect, notice: 'Construction effect was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @effect_construction_effect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /effect/construction_effects/1
  # DELETE /effect/construction_effects/1.json
  def destroy
    @effect_construction_effect = Effect::ConstructionEffect.find(params[:id])
    @effect_construction_effect.destroy

    respond_to do |format|
      format.html { redirect_to effect_construction_effects_url }
      format.json { head :ok }
    end
  end
end
