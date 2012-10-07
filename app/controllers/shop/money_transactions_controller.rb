require 'credit_shop'

class Shop::MoneyTransactionsController < ApplicationController
  layout 'shop'

  before_filter :authenticate
  before_filter :deny_api
  
  def index
    
    logger.debug params.inspect
    logger.debug '---> ' + params[:update].inspect
    
    if params.has_key?(:update)
      shop = CreditShop::BytroShop.new(request)
      shop.update_money_transactions      
    end
    
    @money_transactions = Shop::MoneyTransaction.paginate(:order => 'uid desc', :page => params[:page], :per_page => 20)    
    @paginate = true    
    
    @last_update = Shop::MoneyTransaction.order('uid desc').first.updated_at

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
