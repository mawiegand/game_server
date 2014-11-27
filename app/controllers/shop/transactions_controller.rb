require 'credit_shop'

class Shop::TransactionsController < ApplicationController
  layout 'shop'

  before_filter :authenticate
  before_filter :deny_api,        :except => [:create]
  before_filter :authorize_staff, :except => [:create]
  
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
    elsif offer_type === 'platinum'
      offer = Shop::PlatinumOffer.find(params[:shop_transaction][:offer_id])
    elsif offer_type === 'special_offer'
      offer = Shop::SpecialOffer.find(params[:shop_transaction][:offer_id])
      raise BadRequestError.new('no special offer') if offer.nil?
      raise ForbiddenError.new('already bought special offer') unless offer.buyable_by_character(current_character)
    else
      raise BadRequestError.new('invalid offer type')
    end

    if offer_type === 'bonus' && offer.currency === Shop::Transaction::CURRENCY_GOLDEN_FROGS
      price = { 3 => offer.price }
      raise ForbiddenError.new('not enough resources to pay for offer') unless current_character.resource_pool.have_at_least_resources(price)
      current_character.resource_pool.remove_resources_transaction(price)
      success = offer.credit_to(current_character)

      @shop_transaction = Shop::Transaction.new({
        character: current_character,
        offer: offer.to_json,
        state: Shop::Transaction::STATE_CLOSED
      })
    elsif offer_type === 'special_offer'
      ActiveRecord::Base.transaction(:requires_new => true) do

        shop_special_offers_transaction = Shop::SpecialOffersTransaction.find_or_create_by_character_id_and_external_offer_id(current_character.id, offer.external_offer_id)
        shop_special_offers_transaction.lock!

        if shop_special_offers_transaction.purchase.nil?
          purchase = shop_special_offers_transaction.create_purchase({
            character_id:      current_character.id,
            external_offer_id: offer.external_offer_id,
          })
        else
          purchase = shop_special_offers_transaction.purchase
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
          transaction_id: @shop_transaction.id,
        }

        account_response = CreditShop::BytroShop.get_customer_account(current_character.identifier)
        raise BadRequestError.new("Could not connect to Shop to get account balance") unless (account_response[:response_code] == Shop::Transaction::API_RESPONSE_OK)
        credit_amount = account_response[:response_data][:amount]

        @shop_transaction.credit_amount_before = credit_amount
        @shop_transaction.save


        raise ForbiddenError.new('too few credits') if credit_amount < offer.price
        transaction_response = CreditShop::BytroShop.post_virtual_bank_transaction(virtual_bank_transaction, current_character.identifier)

        if transaction_response[:response_code] === Shop::Transaction::API_RESPONSE_OK
          @shop_transaction.credit_amount_after = transaction_response[:response_data][:amount]
          @shop_transaction.state = Shop::Transaction::STATE_CONFIRMED
          @shop_transaction.credit_amount_booked = offer.price
          @shop_transaction.save

          ActiveRecord::Base.transaction(:requires_new => true) do
            if !purchase.redeemed? && !shop_special_offers_transaction.redeemed?
              purchase.special_offer.credit_to(current_character)
              purchase.redeemed_at = Time.now
              purchase.save!

              shop_special_offers_transaction.redeemed_at = Time.now
              shop_special_offers_transaction.state = Shop::Transaction::STATE_REDEEMED
              shop_special_offers_transaction.save!

              @shop_transaction.state = Shop::Transaction::STATE_BOOKED
              @shop_transaction.save
            else
              @shop_transaction.state = Shop::Transaction::STATE_ERROR_NOT_BOOKED
              @shop_transaction.save
              raise BadRequestError.new("Could not book shop offer")
            end
          end

          # transaction abschliessen
          @shop_transaction.state = Shop::Transaction::STATE_CLOSED
          @shop_transaction.save
        else  # payment rejected
          @shop_transaction.state = Shop::Transaction::STATE_REJECTED
          @shop_transaction.save
        end

        success = @shop_transaction.save
      end
    else
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
        transaction_id: @shop_transaction.id,
      }

      account_response = CreditShop::BytroShop.get_customer_account(current_character.identifier)
      raise BadRequestError.new("Could not connect to Shop to get account balance") unless (account_response[:response_code] == Shop::Transaction::API_RESPONSE_OK)
      credit_amount = account_response[:response_data][:amount]

      @shop_transaction.credit_amount_before = credit_amount
      @shop_transaction.save


      raise ForbiddenError.new('too few credits') if credit_amount < offer.price
      transaction_response = CreditShop::BytroShop.post_virtual_bank_transaction(virtual_bank_transaction, current_character.identifier)

      if transaction_response[:response_code] === Shop::Transaction::API_RESPONSE_OK
        @shop_transaction.credit_amount_after = transaction_response[:response_data][:amount]
        @shop_transaction.state = Shop::Transaction::STATE_CONFIRMED
        @shop_transaction.credit_amount_booked = offer.price
        @shop_transaction.save

        ActiveRecord::Base.transaction do
          if offer.credit_to(current_character)
            @shop_transaction.state = Shop::Transaction::STATE_BOOKED
            @shop_transaction.save
          else
            @shop_transaction.state = Shop::Transaction::STATE_ERROR_NOT_BOOKED
            @shop_transaction.save
            raise BadRequestError.new("Could not book shop offer")
          end
        end

        # transaction abschliessen
        @shop_transaction.state = Shop::Transaction::STATE_CLOSED
        @shop_transaction.save
      else  # payment rejected
        @shop_transaction.state = Shop::Transaction::STATE_REJECTED
        @shop_transaction.save
      end

      success = @shop_transaction.save
    end


    respond_to do |format|
      if success
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
