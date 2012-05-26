class Settlement::SettlementsController < ApplicationController
  layout 'settlement'
  
  before_filter :authenticate
  before_filter :deny_api, :except => [:index, :show]

  # GET /settlement/settlements
  # GET /settlement/settlements.json
  # GET /fundamental/character/:character_id/settlements
  # GET /fundamental/character/:character_id/settlements.json
  def index
    last_modified = nil
    
    if params.has_key?(:character_id)
      @character = Fundamental::Character.find(params[:character_id])
      raise NotFoundError.new('Character not found.') if @character.nil?
      @settlement_settlements = @character.settlements
      @settlement_settlements = [] if @settlement_settlements.nil?  # necessary? or ok to send 'null' ?
    else 
      @asked_for_index = true
    end   
    
    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          if @settlement_settlements.nil?
            @settlement_settlements = Settlement::Settlement.paginate(:page => params[:page], :per_page => 50)    
            @paginate = true   
          end 
        end
        format.json do
          if @asked_for_index 
            raise ForbiddenError.new('Access Forbidden')        
          end  

          role = determine_access_role(@character.id, @character.alliance_id)
          logger.debug "Access with role #{role}."

          render json: @settlement_settlements, :only => Settlement::Settlement.readable_attributes(role)
        end
      end
    end
  end

  # GET /settlement/settlements/1
  # GET /settlement/settlements/1.json
  def show
    @settlement_settlement = Settlement::Settlement.find(params[:id])
    raise NotFoundError.new('Page Not Found') if @settlement_settlement.nil?

    last_modified = nil 
    last_modified =  @settlement_settlement.updated_at

    role = determine_access_role(@settlement_settlement.owner_id, @settlement_settlement.alliance_id)
    logger.debug "Access with role #{role}."
    
    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html # show.html.erb
        format.json do
          render json: @settlement_settlement, :only => Settlement::Settlement.readable_attributes(role)
        end
      end
    end
  end

  # GET /settlement/settlements/new
  def new
    @settlement_settlement = Settlement::Settlement.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /settlement/settlements/1/edit
  def edit
    @settlement_settlement = Settlement::Settlement.find(params[:id])
  end

  # POST /settlement/settlements
  def create
    @settlement_settlement = Settlement::Settlement.new(params[:settlement_settlement])

    respond_to do |format|
      if @settlement_settlement.save
        format.html { redirect_to @settlement_settlement, notice: 'Settlement was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /settlement/settlements/1
  def update
    @settlement_settlement = Settlement::Settlement.find(params[:id])

    respond_to do |format|
      if @settlement_settlement.update_attributes(params[:settlement_settlement])
        format.html { redirect_to @settlement_settlement, notice: 'Settlement was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /settlement/settlements/1
  def destroy
    @settlement_settlement = Settlement::Settlement.find(params[:id])
    @settlement_settlement.destroy

    respond_to do |format|
      format.html { redirect_to settlement_settlements_url }
    end
  end
end
