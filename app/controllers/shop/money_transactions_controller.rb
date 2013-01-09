require 'credit_shop'

class Shop::MoneyTransactionsController < ApplicationController
  layout 'shop'

  before_filter :authenticate
  before_filter :authorize_staff
  before_filter :deny_api
  
  def index
    if params.has_key?(:update)
      CreditShop::BytroShop.update_money_transactions      
    end
    
    @money_transactions = Shop::MoneyTransaction.paginate(:order => 'uid desc', :page => params[:page], :per_page => 20)    
    @paginate = true    
    
    last_transaction = Shop::MoneyTransaction.order('uid desc').first
    
    @last_update = last_transaction.nil? ? '-' : last_transaction.updated_at

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
