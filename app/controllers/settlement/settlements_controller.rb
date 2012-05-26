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
      if staff? || (!params[:character_id].blank? && params[:character_id] == current_character.id.to_s)
        @settlement_settlements = Settlement::Settlement.find(:all, :conditions => {:owner_id => params[:character_id]});
        @settlement_settlements = [] if @settlement_settlements.nil?  # necessary? or ok to send 'null' ?
      else
        raise ForbiddenError.new('Access Forbidden')        
      end
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

          if params.has_key?(:short)
            render json: @settlement_settlements, :only => @@short_fields
          elsif params.has_key?(:aggregate)
            render json: @settlement_settlements, :only => @@aggregate_fields          
          else
            render json: @settlement_settlements
          end
        end
      end
    end
  end

  # GET /settlement/settlements/1
  # GET /settlement/settlements/1.json
  def show
    @settlement_settlement = Settlement::Settlement.find(params[:id])
    raise NotFoundError.new('Page Not Found') if @settlement_settlement.nil?
    raise ForbiddenError.new('Access forbidden.') unless staff? || (!current_character.nil? && current_character.id == @settlement_settlement.owner_id)

    last_modified = nil 
    last_modified =  @settlement_settlement.updated_at

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html # show.html.erb
        format.json do
          if params.has_key?(:short)
            render json: @settlement_settlement, :only => @@short_fields
          elsif params.has_key?(:aggregate)
            render json: @settlement_settlement, :only => @@aggregate_fields          
          else
            render json: @settlement_settlement
          end 
        end
      end
    end
  end

  # GET /settlement/settlements/new
  # GET /settlement/settlements/new.json
  def new
    @settlement_settlement = Settlement::Settlement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @settlement_settlement }
    end
  end

  # GET /settlement/settlements/1/edit
  def edit
    @settlement_settlement = Settlement::Settlement.find(params[:id])
  end

  # POST /settlement/settlements
  # POST /settlement/settlements.json
  def create
    @settlement_settlement = Settlement::Settlement.new(params[:settlement_settlement])

    respond_to do |format|
      if @settlement_settlement.save
        format.html { redirect_to @settlement_settlement, notice: 'Settlement was successfully created.' }
        format.json { render json: @settlement_settlement, status: :created, location: @settlement_settlement }
      else
        format.html { render action: "new" }
        format.json { render json: @settlement_settlement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /settlement/settlements/1
  # PUT /settlement/settlements/1.json
  def update
    @settlement_settlement = Settlement::Settlement.find(params[:id])

    respond_to do |format|
      if @settlement_settlement.update_attributes(params[:settlement_settlement])
        format.html { redirect_to @settlement_settlement, notice: 'Settlement was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @settlement_settlement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settlement/settlements/1
  # DELETE /settlement/settlements/1.json
  def destroy
    @settlement_settlement = Settlement::Settlement.find(params[:id])
    @settlement_settlement.destroy

    respond_to do |format|
      format.html { redirect_to settlement_settlements_url }
      format.json { head :ok }
    end
  end
end
