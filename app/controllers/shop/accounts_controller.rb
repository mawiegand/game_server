require 'credit_shop'

class Shop::AccountsController < ApplicationController
  
  before_filter :authenticate
  
  def show
    credit_shop = CreditShop.credit_shop(request)
    account_response = credit_shop.get_customer_account
    raise BadRequestError.new("Could not connect to Shop") if (account_response[:response_code] === Shop::Transaction::API_RESPONSE_ERROR)
    raise NotFoundError.new("User not found in Shop") if (account_response[:response_code] === Shop::Transaction::API_RESPONSE_USER_NOT_FOUND)
    @shop_account = {credit_amount: account_response[:response_data][:amount]}
    
    logger.debug '---> @shop_account' + @shop_account.inspect

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop_account }
    end
  end
end
