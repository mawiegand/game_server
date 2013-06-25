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
    @shop_special_offers_transaction = Shop::SpecialOffersTransaction.new

    # TODO params is an escaped json string an thus, it cannot be parsed properly
    logger.debug "-----> Parameters: " + params.inspect

    # fill transaction
    @shop_special_offers_transaction.character = 220
    @shop_special_offers_transaction.offer_id = 4711
    @shop_special_offers_transaction.state = Shop::Transaction::STATE_CREATED

    # create shop_transaction event
    unless @shop_special_offers_transaction.save
      render json: @shop_special_offers_transaction.errors, status: :unprocessable_entity
    end

    @shop_purchase = Shop::Purchase.new
    @shop_purchase.character_id = @shop_special_offers_transaction.character_id
    @shop_purchase.offer_id = @shop_special_offers_transaction.offer_id
    @shop_purchase.special_offers_transaction_id = @shop_special_offers_transaction.id

    # create purchase object
    unless @shop_purchase.save
      render json: @shop_purchase.errors, status: :unprocessable_entity
    end

      # answer with 201
    render json: {:status => 'created'}, status: :created
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
