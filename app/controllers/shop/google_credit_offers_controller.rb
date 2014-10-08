class Shop::GoogleCreditOffersController < ApplicationController
  layout 'shop'

  before_filter :deny_api       , :except => [:show, :index]
  before_filter :authorize_staff, :except => [:show, :index]

  # GET /shop/google_credit_offers
  # GET /shop/google_credit_offers.json
  def index
    @shop_google_credit_offers = Shop::GoogleCreditOffer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shop_google_credit_offers }
    end
  end

  # GET /shop/google_credit_offers/1
  # GET /shop/google_credit_offers/1.json
  def show
    @shop_google_credit_offer = Shop::GoogleCreditOffer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop_google_credit_offer }
    end
  end

  # GET /shop/google_credit_offers/new
  # GET /shop/google_credit_offers/new.json
  def new
    @shop_google_credit_offer = Shop::GoogleCreditOffer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shop_google_credit_offer }
    end
  end

  # GET /shop/google_credit_offers/1/edit
  def edit
    @shop_google_credit_offer = Shop::GoogleCreditOffer.find(params[:id])
  end

  # POST /shop/google_credit_offers
  # POST /shop/google_credit_offers.json
  def create
    @shop_google_credit_offer = Shop::GoogleCreditOffer.new(params[:shop_google_credit_offer])

    respond_to do |format|
      if @shop_google_credit_offer.save
        format.html { redirect_to @shop_google_credit_offer, notice: 'Google credit offer was successfully created.' }
        format.json { render json: @shop_google_credit_offer, status: :created, location: @shop_google_credit_offer }
      else
        format.html { render action: "new" }
        format.json { render json: @shop_google_credit_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shop/google_credit_offers/1
  # PUT /shop/google_credit_offers/1.json
  def update
    @shop_google_credit_offer = Shop::GoogleCreditOffer.find(params[:id])

    respond_to do |format|
      if @shop_google_credit_offer.update_attributes(params[:shop_google_credit_offer])
        format.html { redirect_to @shop_google_credit_offer, notice: 'Google credit offer was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @shop_google_credit_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop/google_credit_offers/1
  # DELETE /shop/google_credit_offers/1.json
  def destroy
    @shop_google_credit_offer = Shop::GoogleCreditOffer.find(params[:id])
    @shop_google_credit_offer.destroy

    respond_to do |format|
      format.html { redirect_to shop_google_credit_offers_url }
      format.json { head :ok }
    end
  end
end
