class Shop::FbMoneyTransactionsController < ApplicationController
  # GET /shop/fb_money_transactions
  # GET /shop/fb_money_transactions.json
  def index
    @shop_fb_money_transactions = Shop::FbMoneyTransaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shop_fb_money_transactions }
    end
  end

  # GET /shop/fb_money_transactions/1
  # GET /shop/fb_money_transactions/1.json
  def show
    @shop_fb_money_transaction = Shop::FbMoneyTransaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop_fb_money_transaction }
    end
  end

  # GET /shop/fb_money_transactions/new
  # GET /shop/fb_money_transactions/new.json
  def new
    @shop_fb_money_transaction = Shop::FbMoneyTransaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shop_fb_money_transaction }
    end
  end

  # GET /shop/fb_money_transactions/1/edit
  def edit
    @shop_fb_money_transaction = Shop::FbMoneyTransaction.find(params[:id])
  end

  # POST /shop/fb_money_transactions
  # POST /shop/fb_money_transactions.json
  def create
    @shop_fb_money_transaction = Shop::FbMoneyTransaction.new(params[:shop_fb_money_transaction])

    respond_to do |format|
      if @shop_fb_money_transaction.save
        format.html { redirect_to @shop_fb_money_transaction, notice: 'Fb money transaction was successfully created.' }
        format.json { render json: @shop_fb_money_transaction, status: :created, location: @shop_fb_money_transaction }
      else
        format.html { render action: "new" }
        format.json { render json: @shop_fb_money_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shop/fb_money_transactions/1
  # PUT /shop/fb_money_transactions/1.json
  def update
    @shop_fb_money_transaction = Shop::FbMoneyTransaction.find(params[:id])

    respond_to do |format|
      if @shop_fb_money_transaction.update_attributes(params[:shop_fb_money_transaction])
        format.html { redirect_to @shop_fb_money_transaction, notice: 'Fb money transaction was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @shop_fb_money_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop/fb_money_transactions/1
  # DELETE /shop/fb_money_transactions/1.json
  def destroy
    @shop_fb_money_transaction = Shop::FbMoneyTransaction.find(params[:id])
    @shop_fb_money_transaction.destroy

    respond_to do |format|
      format.html { redirect_to shop_fb_money_transactions_url }
      format.json { head :ok }
    end
  end
end
