require 'credit_shop/five_d_payment_provider'

class Shop::TransactionsController < ApplicationController
  layout 'shop'

  before_filter :authenticate
  before_filter :deny_api, :except => [:show, :index, :create]
  
  # GET /shop/transactions
  # GET /shop/transactions.json
  def index
    @shop_transactions = Shop::Transaction.paginate(:order => 'id desc', :page => params[:page], :per_page => 20)    
    @paginate = true 
    
    respond_to do |format|
      format.html # index.html.erb
      format.json {}
    end
  end

  # GET /shop/transactions/1
  # GET /shop/transactions/1.json
  def show
    @shop_transaction = Shop::Transaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop_transaction }
    end
  end

  # GET /shop/transactions/new
  # GET /shop/transactions/new.json
  def new
    @shop_transaction = Shop::Transaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shop_transaction }
    end
  end

  # GET /shop/transactions/1/edit
  def edit
    @shop_transaction = Shop::Transaction.find(params[:id])
  end

  # POST /shop/transactions
  # POST /shop/transactions.json
  def create
    # offer holen
    offer_type = params[:shop_transaction][:offer_type]
    if offer_type === 'resource'
      offer = Shop::ResourceOffer.find(params[:shop_transaction][:offer_id])
    elsif offer_type === 'bonus'
      offer = Shop::BonusOffer.find(params[:shop_transaction][:offer_id])
    else
      raise BadRequestError.new('invalid offer type')
    end
    
    # lokale transaction erzeugen
    @shop_transaction = Shop::Transaction.create({
      character: current_character,
      offer: offer.to_json,
      state: Shop::Transaction::STATE_CREATED
    })
    
    # transaction zum payment provider schicken
    virtual_bank_transaction = {
      customer_identifier: current_character.identifier, # TODO: send access_token instead (to prove, that user has logged in to game server)
      credit_amount_booked: offer.price,
      booking_type: Shop::Transaction::TYPE_DEBIT,
    }
    
    logger.debug virtual_bank_transaction.inspect
    
    credit_shop = CreditShop.credit_shop(request)
    
    @shop_transaction.credit_amount_before = credit_shop.get_customer_account['amount']
    @shop_transaction.save
    
    provider_response = credit_shop.post_virtual_bank_transaction(virtual_bank_transaction)

    @shop_transaction.credit_amount_after = credit_shop.get_customer_account['amount']
    @shop_transaction.save
    
    # lokale transaction aktualisieren
    if provider_response.nil?  # error
      @shop_transaction.state = Shop::Transaction::STATE_ERROR_NO_CONNECTION
      @shop_transaction.save
      raise BadRequestError.new("Could not connect to Shop") 
    elsif provider_response['state'] == Shop::Transaction::STATE_COMMITTED  # payment successful
      ActiveRecord::Base.transaction do
        @shop_transaction.state = Shop::Transaction::STATE_CONFIRMED
        @shop_transaction.credit_amount_booked = offer.price
        @shop_transaction.save
    
        if offer.credit_to(current_character)
          @shop_transaction.state = Shop::Transaction::STATE_BOOKED
          @shop_transaction.save
        else
          @shop_transaction.state = Shop::Transaction::STATE_ERROR_NOT_BOOKED
          @shop_transaction.save     
          raise BadRequestError.new("Could not book toad amount") 
        end
      end

      # TODO callback an payment provider
        
      # transaction abschliessen
      @shop_transaction.state = Shop::Transaction::STATE_CLOSED
      @shop_transaction.save
    else  # payment rejected 
      @shop_transaction.state = Shop::Transaction::STATE_REJECTED
      @shop_transaction.save
    end    
    
    respond_to do |format|
      if @shop_transaction.save
        format.html { redirect_to @shop_transaction, notice: 'Transaction was successfully created.' }
        format.json { render json: @shop_transaction, status: :created, location: @shop_transaction }
      else
        format.html { render action: "new" }
        format.json { render json: @shop_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shop/transactions/1
  # PUT /shop/transactions/1.json
  def update
    @shop_transaction = Shop::Transaction.find(params[:id])

    respond_to do |format|
      if @shop_transaction.update_attributes(params[:shop_transaction])
        format.html { redirect_to @shop_transaction, notice: 'Transaction was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @shop_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop/transactions/1
  # DELETE /shop/transactions/1.json
  def destroy
    @shop_transaction = Shop::Transaction.find(params[:id])
    @shop_transaction.destroy

    respond_to do |format|
      format.html { redirect_to shop_transactions_url }
      format.json { head :ok }
    end
  end
end
