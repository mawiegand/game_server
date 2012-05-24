class Shop::AccountsController < ApplicationController
  
  include Shop::ShopHelper
  
  before_filter :authenticate
  
  def show
    # get user account from payment provider
    @shop_account = {credit_amount: get_customer_account['amount']}

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop_account }
    end
  end
end
