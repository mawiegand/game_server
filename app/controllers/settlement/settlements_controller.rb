class Settlement::SettlementsController < ApplicationController
  layout 'settlement'

  # GET /settlement/settlements
  # GET /settlement/settlements.json
  def index
    @settlement_settlements = Settlement::Settlement.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @settlement_settlements }
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
