class Shop::PlatinumOffersController < ApplicationController
  layout 'shop'

  before_filter :authenticate
  before_filter :deny_api, :except => [:show, :index]

  # GET /shop/platinum_offers
  # GET /shop/platinum_offers.json
  def index
    @shop_platinum_offers = Shop::PlatinumOffer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shop_platinum_offers }
    end
  end

  # GET /shop/platinum_offers/1
  # GET /shop/platinum_offers/1.json
  def show
    @shop_platinum_offer = Shop::PlatinumOffer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop_platinum_offer }
    end
  end

  # GET /shop/platinum_offers/new
  # GET /shop/platinum_offers/new.json
  def new
    @shop_platinum_offer = Shop::PlatinumOffer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shop_platinum_offer }
    end
  end

  # GET /shop/platinum_offers/1/edit
  def edit
    @shop_platinum_offer = Shop::PlatinumOffer.find(params[:id])
  end

  # POST /shop/platinum_offers
  # POST /shop/platinum_offers.json
  def create
    @shop_platinum_offer = Shop::PlatinumOffer.new(params[:shop_platinum_offer])

    respond_to do |format|
      if @shop_platinum_offer.save
        format.html { redirect_to @shop_platinum_offer, notice: 'Platinum offer was successfully created.' }
        format.json { render json: @shop_platinum_offer, status: :created, location: @shop_platinum_offer }
      else
        format.html { render action: "new" }
        format.json { render json: @shop_platinum_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shop/platinum_offers/1
  # PUT /shop/platinum_offers/1.json
  def update
    @shop_platinum_offer = Shop::PlatinumOffer.find(params[:id])

    respond_to do |format|
      if @shop_platinum_offer.update_attributes(params[:shop_platinum_offer])
        format.html { redirect_to @shop_platinum_offer, notice: 'Platinum offer was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @shop_platinum_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop/platinum_offers/1
  # DELETE /shop/platinum_offers/1.json
  def destroy
    @shop_platinum_offer = Shop::PlatinumOffer.find(params[:id])
    @shop_platinum_offer.destroy

    respond_to do |format|
      format.html { redirect_to shop_platinum_offers_url }
      format.json { head :ok }
    end
  end
end
