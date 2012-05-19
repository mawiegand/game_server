class Shop::OffersController < ApplicationController
  # GET /shop/offers
  # GET /shop/offers.json
  def index
    @shop_offers = Shop::Offer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shop_offers }
    end
  end

  # GET /shop/offers/1
  # GET /shop/offers/1.json
  def show
    @shop_offer = Shop::Offer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop_offer }
    end
  end

  # GET /shop/offers/new
  # GET /shop/offers/new.json
  def new
    @shop_offer = Shop::Offer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shop_offer }
    end
  end

  # GET /shop/offers/1/edit
  def edit
    @shop_offer = Shop::Offer.find(params[:id])
  end

  # POST /shop/offers
  # POST /shop/offers.json
  def create
    @shop_offer = Shop::Offer.new(params[:shop_offer])

    respond_to do |format|
      if @shop_offer.save
        format.html { redirect_to @shop_offer, notice: 'Offer was successfully created.' }
        format.json { render json: @shop_offer, status: :created, location: @shop_offer }
      else
        format.html { render action: "new" }
        format.json { render json: @shop_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shop/offers/1
  # PUT /shop/offers/1.json
  def update
    @shop_offer = Shop::Offer.find(params[:id])

    respond_to do |format|
      if @shop_offer.update_attributes(params[:shop_offer])
        format.html { redirect_to @shop_offer, notice: 'Offer was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @shop_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop/offers/1
  # DELETE /shop/offers/1.json
  def destroy
    @shop_offer = Shop::Offer.find(params[:id])
    @shop_offer.destroy

    respond_to do |format|
      format.html { redirect_to shop_offers_url }
      format.json { head :ok }
    end
  end
end
