class Settlement::SettlementsController < ApplicationController
  layout 'settlement'
  
  before_filter :authenticate

  # GET /settlement/settlements
  # GET /settlement/settlements.json
  def index
    last_modified = nil
    
    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          if @settlement_settlements.nil?
            @settlement_settlements = Settlement::Settlement.paginate(:page => params[:page], :per_page => 50)    
            @paginate = true   
          end 
        end
        format.json do
          @settlement_settlements = Settlement::Settlement.find(:all, :conditions => {:owner_id => current_character.id});
          @settlement_settlements = [] if @settlement_settlements.nil?  # necessary? or ok to send 'null' ?
          
          logger.debug @settlement_settlements.inspect
          
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

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @settlement_settlement }
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
