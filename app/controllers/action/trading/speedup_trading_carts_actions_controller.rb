class Action::Trading::SpeedupTradingCartsActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create
    Action::Trading::TradingCartsAction.transaction do
      @tradingcartsaction = Action::Trading::TradingCartsAction.lock.find(params[:action_trading_speedup_trading_carts][:trading_carts_action_id])
      raise ForbiddenError.new('not sender or recipient of trading cart action') unless (@tradingcartsaction.sender == current_character or @tradingcartsaction.recipient == current_character)

      cost = GameRules::Rules.the_rules.trading_speedup[0]
      price = { cost[:resource_id] => cost[:amount] }
      
      unless current_character.resource_pool.have_at_least_resources(price)
        raise ForbiddenError.new('not enough resources to pay for finishing job')
      end
      
      @tradingcartsaction.speedup
      current_character.resource_pool.remove_resources_transaction(price)

#      entry = nil
#      GameRules::Rules.the_rules.artifact_initiation_speedup.each do |item|
#        entry = item if entry.nil? && @artifact.initiation.finished_at < Time.now + item[:hours].hours
#      end
    end
    
    respond_to do |format|
        format.json { render json: {}, status: :ok }
    end
  end
end
