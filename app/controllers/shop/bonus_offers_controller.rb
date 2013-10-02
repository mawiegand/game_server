class Shop::BonusOffersController < ApplicationController
  layout 'shop'
  
  before_filter :authenticate
  before_filter :deny_api,        :except => [:show, :index]
  before_filter :authorize_staff, :except => [:show, :index]
  
  # GET /shop/bonus_offers
  # GET /shop/bonus_offers.json
  def index
    @shop_bonus_offers = Shop::BonusOffer.order('resource_id asc, currency asc, price asc')
    
    respond_to do |format|
      format.html # index.html.erb
      format.json do
        @shop_bonus_offers.each do |offer|
          offer[:resource_effect] = offer.effect_for_character(current_character) 
        end
    
        render json: @shop_bonus_offers
      end
    end
  end

  # GET /shop/bonus_offers/1
  # GET /shop/bonus_offers/1.json
  def show
    @shop_bonus_offer = Shop::BonusOffer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop_bonus_offer }
    end
  end

  # GET /shop/bonus_offers/new
  # GET /shop/bonus_offers/new.json
  def new
    @shop_bonus_offer = Shop::BonusOffer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shop_bonus_offer }
    end
  end

  # GET /shop/bonus_offers/1/edit
  def edit
    @shop_bonus_offer = Shop::BonusOffer.find(params[:id])
  end

  # POST /shop/bonus_offers
  # POST /shop/bonus_offers.json
  def create
    @shop_bonus_offer = Shop::BonusOffer.new(params[:shop_bonus_offer])

    respond_to do |format|
      if @shop_bonus_offer.save
        format.html { redirect_to @shop_bonus_offer, notice: 'Bonus offer was successfully created.' }
        format.json { render json: @shop_bonus_offer, status: :created, location: @shop_bonus_offer }
      else
        format.html { render action: "new" }
        format.json { render json: @shop_bonus_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shop/bonus_offers/1
  # PUT /shop/bonus_offers/1.json
  def update
    @shop_bonus_offer = Shop::BonusOffer.find(params[:id])

    respond_to do |format|
      if @shop_bonus_offer.update_attributes(params[:shop_bonus_offer])
        format.html { redirect_to @shop_bonus_offer, notice: 'Bonus offer was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @shop_bonus_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop/bonus_offers/1
  # DELETE /shop/bonus_offers/1.json
  def destroy
    @shop_bonus_offer = Shop::BonusOffer.find(params[:id])
    @shop_bonus_offer.destroy

    respond_to do |format|
      format.html { redirect_to shop_bonus_offers_url }
      format.json { head :ok }
    end
  end
end
