require 'credit_shop'

class Shop::AccountsController < ApplicationController
  
  before_filter :authenticate
  
  def show
    account_response = CreditShop::BytroShop.get_customer_account(current_character.identifier)
    raise BadRequestError.new("Could not connect to Shop") if (account_response[:response_code] === Shop::Transaction::API_RESPONSE_ERROR)
    raise NotFoundError.new("User not found in Shop") if (account_response[:response_code] === Shop::Transaction::API_RESPONSE_USER_NOT_FOUND)
    @shop_account = {shop_account: {credit_amount: account_response[:response_data][:amount]}}
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop_account }
    end
  end
end
