class Shop::GoogleMoneyTransactionsController < ApplicationController
  layout 'shop'

  before_filter :authenticate
  before_filter :authorize_staff
  before_filter :deny_api

  # GET /shop/google_money_transactions
  # GET /shop/google_money_transactions.json
  def index
    @shop_google_money_transactions = Shop::GoogleMoneyTransaction.all
    @paginate = true

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shop_google_money_transactions }
    end
  end

  # GET /shop/google_money_transactions/1
  # GET /shop/google_money_transactions/1.json
  def show
    @shop_google_money_transaction = Shop::GoogleMoneyTransaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop_google_money_transaction }
    end
  end

  # GET /shop/google_money_transactions/new
  # GET /shop/google_money_transactions/new.json
  def new
    @shop_google_money_transaction = Shop::GoogleMoneyTransaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shop_google_money_transaction }
    end
  end

  # GET /shop/google_money_transactions/1/edit
  def edit
    @shop_google_money_transaction = Shop::GoogleMoneyTransaction.find(params[:id])
  end

  # POST /shop/google_money_transactions
  # POST /shop/google_money_transactions.json
  def create
    @shop_google_money_transaction = Shop::GoogleMoneyTransaction.new(params[:shop_google_money_transaction])

    respond_to do |format|
      if @shop_google_money_transaction.save
        format.html { redirect_to @shop_google_money_transaction, notice: 'Google money transaction was successfully created.' }
        format.json { render json: @shop_google_money_transaction, status: :created, location: @shop_google_money_transaction }
      else
        format.html { render action: "new" }
        format.json { render json: @shop_google_money_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shop/google_money_transactions/1
  # PUT /shop/google_money_transactions/1.json
  def update
    @shop_google_money_transaction = Shop::GoogleMoneyTransaction.find(params[:id])

    respond_to do |format|
      if @shop_google_money_transaction.update_attributes(params[:shop_google_money_transaction])
        format.html { redirect_to @shop_google_money_transaction, notice: 'Google money transaction was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @shop_google_money_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop/google_money_transactions/1
  # DELETE /shop/google_money_transactions/1.json
  def destroy
    @shop_google_money_transaction = Shop::GoogleMoneyTransaction.find(params[:id])
    @shop_google_money_transaction.destroy

    respond_to do |format|
      format.html { redirect_to shop_google_money_transactions_url }
      format.json { head :ok }
    end
  end
end
