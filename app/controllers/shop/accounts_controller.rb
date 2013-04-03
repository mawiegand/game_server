require 'credit_shop'

class Shop::AccountsController < ApplicationController
  
  before_filter :authenticate
  
  def show
    account_response = CreditShop::BytroShop.get_customer_account(current_character.identifier)
    raise BadRequestError.new("Could not connect to Shop") if (account_response[:response_code] === Shop::Transaction::API_RESPONSE_ERROR)
    raise NotFoundError.new("User not found in Shop") if (account_response[:response_code] === Shop::Transaction::API_RESPONSE_USER_NOT_FOUND)
    shop_account = {
      id:            current_character.id,
      created_at:    Time.now,
      updated_at:    Time.now,
      credit_amount: account_response[:response_data][:amount]
    }
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: include_root(shop_account, :shop_account) }
    end
  end
end
