class Shop::ResourceOffersController < ApplicationController
  layout 'shop'
  
  before_filter :authenticate
  before_filter :deny_api,        :except => [:show, :index]
  before_filter :authorize_staff, :except => [:show, :index]
  
  # GET /shop/resource_offers
  # GET /shop/resource_offers.json
  def index
    if backend_request?
      @shop_resource_offers = Shop::ResourceOffer.all
    else      
      @shop_resource_offers = Shop::ResourceOffer.where(["(started_at is null or started_at < ?) and (ends_at is null or ends_at > ?)", Time.now, Time.now])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shop_resource_offers }
    end
  end

  # GET /shop/resource_offers/1
  # GET /shop/resource_offers/1.json
  def show
    @shop_resource_offer = Shop::ResourceOffer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop_resource_offer }
    end
  end

  # GET /shop/resource_offers/new
  # GET /shop/resource_offers/new.json
  def new
    @shop_resource_offer = Shop::ResourceOffer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shop_resource_offer }
    end
  end

  # GET /shop/resource_offers/1/edit
  def edit
    @shop_resource_offer = Shop::ResourceOffer.find(params[:id])
  end

  # POST /shop/resource_offers
  # POST /shop/resource_offers.json
  def create
    @shop_resource_offer = Shop::ResourceOffer.new(params[:shop_resource_offer])

    respond_to do |format|
      if @shop_resource_offer.save
        format.html { redirect_to @shop_resource_offer, notice: 'Resource offer was successfully created.' }
        format.json { render json: @shop_resource_offer, status: :created, location: @shop_resource_offer }
      else
        format.html { render action: "new" }
        format.json { render json: @shop_resource_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shop/resource_offers/1
  # PUT /shop/resource_offers/1.json
  def update
    @shop_resource_offer = Shop::ResourceOffer.find(params[:id])

    respond_to do |format|
      if @shop_resource_offer.update_attributes(params[:shop_resource_offer])
        format.html { redirect_to @shop_resource_offer, notice: 'Resource offer was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @shop_resource_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop/resource_offers/1
  # DELETE /shop/resource_offers/1.json
  def destroy
    @shop_resource_offer = Shop::ResourceOffer.find(params[:id])
    @shop_resource_offer.destroy

    respond_to do |format|
      format.html { redirect_to shop_resource_offers_url }
      format.json { head :ok }
    end
  end
end
