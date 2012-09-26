require 'credit_shop'

class Shop::MoneyTransactionsController < ApplicationController
  layout 'shop'

  before_filter :authenticate
  before_filter :deny_api
  
  def index
    credit_shop = CreditShop.credit_shop(request)
    api_response = credit_shop.get_money_transactions
    
    if api_response[:response_code] == Shop::Transaction::API_RESPONSE_OK
      @money_transactions = api_response[:response_data][:transactions]
    else
      @money_transactions = []
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
