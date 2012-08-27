class Action::Trading::TradingCartsActionsController < ApplicationController
  # GET /action/trading/trading_carts_actions
  # GET /action/trading/trading_carts_actions.json
  def index
    @action_trading_trading_carts_actions = Action::Trading::TradingCartsAction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @action_trading_trading_carts_actions }
    end
  end

  # GET /action/trading/trading_carts_actions/1
  # GET /action/trading/trading_carts_actions/1.json
  def show
    @action_trading_trading_carts_action = Action::Trading::TradingCartsAction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @action_trading_trading_carts_action }
    end
  end

  # GET /action/trading/trading_carts_actions/new
  # GET /action/trading/trading_carts_actions/new.json
  def new
    @action_trading_trading_carts_action = Action::Trading::TradingCartsAction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @action_trading_trading_carts_action }
    end
  end

  # GET /action/trading/trading_carts_actions/1/edit
  def edit
    @action_trading_trading_carts_action = Action::Trading::TradingCartsAction.find(params[:id])
  end

  # POST /action/trading/trading_carts_actions
  # POST /action/trading/trading_carts_actions.json
  def create
    @action_trading_trading_carts_action = Action::Trading::TradingCartsAction.new(params[:action_trading_trading_carts_action])

    respond_to do |format|
      if @action_trading_trading_carts_action.save
        format.html { redirect_to @action_trading_trading_carts_action, notice: 'Trading carts action was successfully created.' }
        format.json { render json: @action_trading_trading_carts_action, status: :created, location: @action_trading_trading_carts_action }
      else
        format.html { render action: "new" }
        format.json { render json: @action_trading_trading_carts_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /action/trading/trading_carts_actions/1
  # PUT /action/trading/trading_carts_actions/1.json
  def update
    @action_trading_trading_carts_action = Action::Trading::TradingCartsAction.find(params[:id])

    respond_to do |format|
      if @action_trading_trading_carts_action.update_attributes(params[:action_trading_trading_carts_action])
        format.html { redirect_to @action_trading_trading_carts_action, notice: 'Trading carts action was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @action_trading_trading_carts_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /action/trading/trading_carts_actions/1
  # DELETE /action/trading/trading_carts_actions/1.json
  def destroy
    @action_trading_trading_carts_action = Action::Trading::TradingCartsAction.find(params[:id])
    @action_trading_trading_carts_action.destroy

    respond_to do |format|
      format.html { redirect_to action_trading_trading_carts_actions_url }
      format.json { head :ok }
    end
  end
end
