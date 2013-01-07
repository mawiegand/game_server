require 'credit_shop'

class Shop::CreditTransactionsController < ApplicationController
  layout 'shop'

  before_filter :deny_api
  before_filter :authorize_staff

  
  def index
    if params.has_key?(:update)
      CreditShop::BytroShop.update_ingame_transactions      
    end
    
    @credit_transactions = Shop::CreditTransaction.paginate(:order => 'uid desc', :page => params[:page], :per_page => 20) || []    
    @paginate = true    
    
    last_transaction = Shop::CreditTransaction.order('uid desc').first
    
    @last_update = last_transaction.nil? ? '-' : last_transaction.updated_at

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def create
    character = Fundamental::Character.find_by_identifier(params[:shop_credit_transaction][:partner_user_id])
    booking_amount = -params[:shop_credit_transaction][:scale_factor].to_i
    
    if booking_amount == 0 || !admin?
      redirect_to fundamental_character_path(character.id)
      return
    end 
    
    # lokale transaction erzeugen
    @shop_transaction = Shop::Transaction.create({
      character: character,
      offer: 'custom accounting transaction',
      state: Shop::Transaction::STATE_CREATED
    })
    
    # transaction zum payment provider schicken
    virtual_bank_transaction = {
      customer_identifier: character.identifier,
      credit_amount_booked: booking_amount,
      booking_type: booking_amount > 0 ? Shop::Transaction::TYPE_DEBIT : Shop::Transaction::TYPE_CREDIT,
      transaction_id: @shop_transaction.id,
    }
    
    account_response = CreditShop::BytroShop.get_customer_account(character.identifier)
    raise BadRequestError.new("Could not connect to Shop to get account balance") unless (account_response[:response_code] == Shop::Transaction::API_RESPONSE_OK)
    credit_amount = account_response[:response_data][:amount]
     
    @shop_transaction.credit_amount_before = credit_amount
    @shop_transaction.save
    
    
    if (credit_amount >= booking_amount)

      transaction_response = CreditShop::BytroShop.post_virtual_bank_transaction(virtual_bank_transaction, character.identifier)
  
      if transaction_response[:response_code] === Shop::Transaction::API_RESPONSE_OK
        @shop_transaction.credit_amount_after = transaction_response[:response_data][:amount]
        @shop_transaction.state = Shop::Transaction::STATE_CLOSED
        @shop_transaction.credit_amount_booked = booking_amount
        @shop_transaction.save
      end
    end    

    respond_to do |format|
      format.html { redirect_to fundamental_character_path(character.id) }
    end
  end
end
