class Shop::SpecialOffersController < ApplicationController
  layout 'shop'

  before_filter :authenticate
  before_filter :deny_api,        :except => [:show, :index]
  before_filter :authorize_staff, :except => [:show, :index]

  # GET /shop/special_offers
  # GET /shop/special_offers.json
  def index
    @shop_special_offers = Shop::SpecialOffer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shop_special_offers }
    end
  end

  # GET /shop/special_offers/1
  # GET /shop/special_offers/1.json
  def show
    @shop_special_offer = Shop::SpecialOffer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop_special_offer }
    end
  end

  # GET /shop/special_offers/new
  # GET /shop/special_offers/new.json
  def new
    @shop_special_offer = Shop::SpecialOffer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shop_special_offer }
    end
  end

  # GET /shop/special_offers/1/edit
  def edit
    @shop_special_offer = Shop::SpecialOffer.find(params[:id])
  end

  # POST /shop/special_offers
  # POST /shop/special_offers.json
  def create
    @shop_special_offer = Shop::SpecialOffer.new(params[:shop_special_offer])

    respond_to do |format|
      if @shop_special_offer.save
        format.html { redirect_to @shop_special_offer, notice: 'Special offer was successfully created.' }
        format.json { render json: @shop_special_offer, status: :created, location: @shop_special_offer }
      else
        format.html { render action: "new" }
        format.json { render json: @shop_special_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shop/special_offers/1
  # PUT /shop/special_offers/1.json
  def update
    @shop_special_offer = Shop::SpecialOffer.find(params[:id])

    respond_to do |format|
      if @shop_special_offer.update_attributes(params[:shop_special_offer])
        format.html { redirect_to @shop_special_offer, notice: 'Special offer was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @shop_special_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop/special_offers/1
  # DELETE /shop/special_offers/1.json
  def destroy
    @shop_special_offer = Shop::SpecialOffer.find(params[:id])
    @shop_special_offer.destroy

    respond_to do |format|
      format.html { redirect_to shop_special_offers_url }
      format.json { head :ok }
    end
  end
end
