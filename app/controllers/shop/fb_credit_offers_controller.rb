class Shop::FbCreditOffersController < ApplicationController
  layout 'shop'

  before_filter :deny_api       , :except => [:show, :index]
  before_filter :authorize_staff, :except => [:show, :index]

  # GET /shop/fb_credit_offers
  # GET /shop/fb_credit_offers.json
  def index
    @shop_fb_credit_offers = Shop::FbCreditOffer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shop_fb_credit_offers }
    end
  end

  # GET /shop/fb_credit_offers/1
  # GET /shop/fb_credit_offers/1.json
  def show
    @shop_fb_credit_offer = Shop::FbCreditOffer.find(params[:id])

    @prices = []

    JSON.parse(@shop_fb_credit_offer.prices).each do |o|
      @prices << o
    end

    respond_to do |format|
      format.html { render layout: 'empty' }
      format.json { render json: @shop_fb_credit_offer }
    end
  end

  # GET /shop/fb_credit_offers/new
  # GET /shop/fb_credit_offers/new.json
  def new
    @shop_fb_credit_offer = Shop::FbCreditOffer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shop_fb_credit_offer }
    end
  end

  # GET /shop/fb_credit_offers/1/edit
  def edit
    @shop_fb_credit_offer = Shop::FbCreditOffer.find(params[:id])
  end

  # POST /shop/fb_credit_offers
  # POST /shop/fb_credit_offers.json
  def create
    @shop_fb_credit_offer = Shop::FbCreditOffer.new(params[:shop_fb_credit_offer])

    respond_to do |format|
      if @shop_fb_credit_offer.save
        format.html { redirect_to @shop_fb_credit_offer, notice: 'Fb credit offer was successfully created.' }
        format.json { render json: @shop_fb_credit_offer, status: :created, location: @shop_fb_credit_offer }
      else
        format.html { render action: "new" }
        format.json { render json: @shop_fb_credit_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shop/fb_credit_offers/1
  # PUT /shop/fb_credit_offers/1.json
  def update
    @shop_fb_credit_offer = Shop::FbCreditOffer.find(params[:id])

    respond_to do |format|
      if @shop_fb_credit_offer.update_attributes(params[:shop_fb_credit_offer])
        format.html { redirect_to @shop_fb_credit_offer, notice: 'Fb credit offer was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @shop_fb_credit_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop/fb_credit_offers/1
  # DELETE /shop/fb_credit_offers/1.json
  def destroy
    @shop_fb_credit_offer = Shop::FbCreditOffer.find(params[:id])
    @shop_fb_credit_offer.destroy

    respond_to do |format|
      format.html { redirect_to shop_fb_credit_offers_url }
      format.json { head :ok }
    end
  end
end
