class Effect::ResourceEffectsController < ApplicationController
  layout 'effect'
  
  before_filter :authenticate
  before_filter :deny_api, :except => [:index]

  # GET /effect/resource_effects
  # GET /effect/resource_effects.json
  def index
    last_modified = nil

    if params.has_key?(:resource_pool_id)
      pool = Fundamental::ResourcePool.find(params[:resource_pool_id])
      raise NotFoundError.new('Page Not Found') if pool.nil?
      raise ForbiddenError.new('Access Forbidden') if !admin? && !staff? && !developer? && pool.owner != current_character
      @effect_resource_effects = pool.resource_effects
      #last_modified = pool.updated_at
    else
      @asked_for_index = true
    end

    #render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          if @effect_resource_effects.nil?
            @effect_resource_effects = Effect::ResourceEffect.paginate(:page => params[:page], :per_page => 50)
            @paginate = true
          end
        end
        format.json do
          raise ForbiddenError.new('Access Forbidden') if @asked_for_index
          render json: @effect_resource_effects
        end
      end
    #end
  end

  # GET /effect/resource_effects/1
  # GET /effect/resource_effects/1.json
  def show
    @effect_resource_effect = Effect::ResourceEffect.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @effect_resource_effect }
    end
  end

  # GET /effect/resource_effects/new
  # GET /effect/resource_effects/new.json
  def new
    @effect_resource_effect = Effect::ResourceEffect.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @effect_resource_effect }
    end
  end

  # GET /effect/resource_effects/1/edit
  def edit
    @effect_resource_effect = Effect::ResourceEffect.find(params[:id])
  end

  # POST /effect/resource_effects
  # POST /effect/resource_effects.json
  def create
    @effect_resource_effect = Effect::ResourceEffect.new(params[:effect_resource_effect])

    respond_to do |format|
      if @effect_resource_effect.save
        format.html { redirect_to @effect_resource_effect, notice: 'Resource effect was successfully created.' }
        format.json { render json: @effect_resource_effect, status: :created, location: @effect_resource_effect }
      else
        format.html { render action: "new" }
        format.json { render json: @effect_resource_effect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /effect/resource_effects/1
  # PUT /effect/resource_effects/1.json
  def update
    @effect_resource_effect = Effect::ResourceEffect.find(params[:id])

    respond_to do |format|
      if @effect_resource_effect.update_attributes(params[:effect_resource_effect])
        format.html { redirect_to @effect_resource_effect, notice: 'Resource effect was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @effect_resource_effect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /effect/resource_effects/1
  # DELETE /effect/resource_effects/1.json
  def destroy
    @effect_resource_effect = Effect::ResourceEffect.find(params[:id])
    @effect_resource_effect.destroy

    respond_to do |format|
      format.html { redirect_to effect_resource_effects_url }
      format.json { head :ok }
    end
  end
end
