require 'credit_shop'

class Shop::CreditTransactionsController < ApplicationController
  layout 'shop'

  before_filter :authenticate
  before_filter :deny_api
  
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
end
