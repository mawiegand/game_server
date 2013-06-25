class Shop::SpecialOffersTransactionsController < ApplicationController
  layout 'shop'

  before_filter :authenticate,         :except => [:create]
  before_filter :deny_api,             :except => [:create]
  #before_filter :authorize_bytro_shop, :only   => [:create]

  # GET /shop/special_offers_transactions
  # GET /shop/special_offers_transactions.json
  def index
    @shop_special_offers_transactions = Shop::SpecialOffersTransaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shop_special_offers_transactions }
    end
  end

  # GET /shop/special_offers_transactions/1
  # GET /shop/special_offers_transactions/1.json
  def show
    @shop_special_offers_transaction = Shop::SpecialOffersTransaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop_special_offers_transaction }
    end
  end

  # GET /shop/special_offers_transactions/new
  # GET /shop/special_offers_transactions/new.json
  def new
    @shop_special_offers_transaction = Shop::SpecialOffersTransaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shop_special_offers_transaction }
    end
  end

  # GET /shop/special_offers_transactions/1/edit
  def edit
    @shop_special_offers_transaction = Shop::SpecialOffersTransaction.find(params[:id])
  end

  # POST /shop/special_offers_transactions
  # POST /shop/special_offers_transactions.json
  def create
    # create shop transaction
    @shop_special_offers_transaction = Shop::SpecialOffersTransaction.new(params[:shop_special_offers_transaction])

    logger.debug "-----> Parameters: " + params.inspect

    # TODO set transaction attributes

    # create shop_transaction event
    if !@shop_special_offers_transaction.save
      render json: @shop_special_offers_transaction.errors, status: :unprocessable_entity
    end

    # answer with 201
    render json: {:callback => 'successful', :schoene => 'gruesse'}, status: :created
  end

  # PUT /shop/special_offers_transactions/1
  # PUT /shop/special_offers_transactions/1.json
  def update
    @shop_special_offers_transaction = Shop::SpecialOffersTransaction.find(params[:id])

    respond_to do |format|
      if @shop_special_offers_transaction.update_attributes(params[:shop_special_offers_transaction])
        format.html { redirect_to @shop_special_offers_transaction, notice: 'Special offers transaction was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @shop_special_offers_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop/special_offers_transactions/1
  # DELETE /shop/special_offers_transactions/1.json
  def destroy
    @shop_special_offers_transaction = Shop::SpecialOffersTransaction.find(params[:id])
    @shop_special_offers_transaction.destroy

    respond_to do |format|
      format.html { redirect_to shop_special_offers_transactions_url }
      format.json { head :ok }
    end
  end
end
