require 'credit_shop'

class Shop::AccountsController < ApplicationController
  
  before_filter :authenticate
  
  def show
    credit_shop = CreditShop.credit_shop(request)
    
    # get user account from payment provider
    @shop_account = {credit_amount: credit_shop.get_customer_account['amount']}

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop_account }
    end
  end
end
