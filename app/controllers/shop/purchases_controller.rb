class Shop::PurchasesController < ApplicationController
  layout 'shop'

  before_filter :authenticate
  before_filter :deny_api,             :except => [:index]
  before_filter :authorize_staff,      :except => [:index]
  

  # GET /shop/purchases
  # GET /shop/purchases.json
  def index
    if params.has_key?(:character_id)
      @character = Fundamental::Character.find(params[:character_id])
      raise ForbiddenError.new('Access Forbidden') unless admin? || staff? || current_character == @character
      raise NotFoundError.new('Page Not Found') if @character.nil?
      @shop_purchases = @character.purchases
    else
      raise ForbiddenError.new('Access Forbidden') unless admin? || staff?
      @shop_purchases = Shop::Purchase.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shop_purchases }
    end
  end

  # GET /shop/purchases/1
  # GET /shop/purchases/1.json
  def show
    @shop_purchase = Shop::Purchase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop_purchase }
    end
  end

  # GET /shop/purchases/new
  # GET /shop/purchases/new.json
  def new
    @shop_purchase = Shop::Purchase.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shop_purchase }
    end
  end

  # GET /shop/purchases/1/edit
  def edit
    @shop_purchase = Shop::Purchase.find(params[:id])
  end

  # POST /shop/purchases
  # POST /shop/purchases.json
  def create
    @shop_purchase = Shop::Purchase.new(params[:shop_purchase])

    respond_to do |format|
      if @shop_purchase.save
        format.html { redirect_to @shop_purchase, notice: 'Purchase was successfully created.' }
        format.json { render json: @shop_purchase, status: :created, location: @shop_purchase }
      else
        format.html { render action: "new" }
        format.json { render json: @shop_purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shop/purchases/1
  # PUT /shop/purchases/1.json
  def update
    @shop_purchase = Shop::Purchase.find(params[:id])

    respond_to do |format|
      if @shop_purchase.update_attributes(params[:shop_purchase])
        format.html { redirect_to @shop_purchase, notice: 'Purchase was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @shop_purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop/purchases/1
  # DELETE /shop/purchases/1.json
  def destroy
    @shop_purchase = Shop::Purchase.find(params[:id])
    @shop_purchase.destroy

    respond_to do |format|
      format.html { redirect_to shop_purchases_url }
      format.json { head :ok }
    end
  end
end
