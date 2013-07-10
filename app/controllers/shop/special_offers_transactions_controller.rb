require 'digest/md5'

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

    if request.request_parameters.nil? || request.request_parameters[:hash].nil?
      render json: {:status => 'missing hash'}, status: :bad_request
      return
    end

    #remove hash from post params
    post_params = request.request_parameters
    post_params.delete('hash')

    logger.debug "HASH_BASE:   " + post_params.to_param
    logger.debug "BASE HASHED: " + Digest::SHA1.hexdigest(post_params.to_param)
    logger.debug "HASH VALUE:  " + params[:hash]

    #if Digest::MD5.hexdigest(post_params.to_param) != params[:hash]
    #  render json: {:status => 'wrong hash'}, status: :forbidden
    #  return
    #end

    # create shop transaction
    @shop_special_offers_transaction = Shop::SpecialOffersTransaction.new

    character = Fundamental::Character.find_by_identifier(params[:partnerUserID])
    if character.nil?
      render json: {:status => 'character not found'}, status: :not_found
      return
    end

    special_offer = Shop::SpecialOffer.find_by_external_offer_id(params[:offerID])
    if special_offer.nil? # there is no special offer for this id, callback was sent based on a regular credit offer
      render json: {:status => 'regular offer processed'}, status: :created
      return
    end

    # fill transaction
    @shop_special_offers_transaction.character_id = character.id
    @shop_special_offers_transaction.external_offer_id = special_offer.external_offer_id
    @shop_special_offers_transaction.state = Shop::Transaction::STATE_CREATED

    # create shop_transaction event
    unless @shop_special_offers_transaction.save
      render json: @shop_special_offers_transaction.errors, status: :unprocessable_entity
      return
    end

    @shop_purchase = Shop::Purchase.new
    @shop_purchase.character_id = @shop_special_offers_transaction.character_id
    @shop_purchase.external_offer_id = @shop_special_offers_transaction.external_offer_id
    @shop_purchase.special_offers_transaction_id = @shop_special_offers_transaction.id

    # create purchase object
    unless @shop_purchase.save
      render json: @shop_purchase.errors, status: :unprocessable_entity
      return
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
