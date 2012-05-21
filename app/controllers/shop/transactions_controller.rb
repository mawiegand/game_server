class Shop::TransactionsController < ApplicationController
  
  # GET /shop/transactions
  # GET /shop/transactions.json
  def index
    @shop_transactions = Shop::Transaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shop_transactions }
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
    offer = Shop::Offer.find(params[:shop_transaction][:offer_id])
    
    # lokale transaction erzeugen
    @shop_transaction = Shop::Transaction.create({
      character: current_character,
      offer: offer.to_json,
      state: Shop::Transaction::STATE_CREATED
    })
    
    # transaction zum payment provider schicken
    virtual_bank_transaction = {
      customer_identifier: current_character.identifier,
      credit_amount_booked: offer.price,
      booking_type: Shop::Transaction::TYPE_DEBIT,
    }
    
    logger.debug virtual_bank_transaction.inspect
    
    provider_response = HTTParty.post('https://uni.patrickfox.de/payment_provider/virtual_bank/transactions.json', {query: {virtual_bank_transaction: virtual_bank_transaction}}).parsed_response
    logger.debug '------------------------------------'
    logger.debug provider_response.inspect
    logger.debug '------------------------------------'
    # vbt_id merken für callback!
    
    logger.debug provider_response['state']
    logger.debug Shop::Transaction::STATE_COMMITTED
    logger.debug '------------------------------------'
    
    # lokale transaction aktualisieren
    if provider_response.nil?  # error
      @shop_transaction.state = Shop::Transaction::STATE_ERROR
      @shop_transaction.save
      raise BadRequestError.new("Could not connect to Payment Provider") 
    elsif provider_response['state'] == Shop::Transaction::STATE_COMMITTED  # payment successful
      ActiveRecord::Base.transaction do
        @shop_transaction.state = Shop::Transaction::STATE_CONFIRMED
        @shop_transaction.credit_amount_booked = offer.price
        @shop_transaction.save

        # Offer in Character buchen
        current_character.frog_amount += offer.amount
        current_character.save    
      end

        # callback an payment provider
        
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
