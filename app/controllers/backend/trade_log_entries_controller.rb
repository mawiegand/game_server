class Backend::TradeLogEntriesController < ApplicationController
  layout 'backend'

  before_filter :deny_api
  before_filter :authenticate_backend 
  before_filter :authorize_staff 
  
  # GET /backend/trade_log_entries
  # GET /backend/trade_log_entries.json
  def index
    @backend_trade_log_entries = Backend::TradeLogEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @backend_trade_log_entries }
    end
  end
end
