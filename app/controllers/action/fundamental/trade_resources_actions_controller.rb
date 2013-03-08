class Action::Fundamental::TradeResourcesActionsController < ApplicationController
  layout 'action'
  before_filter :authenticate

  EXCHANGE_FEE = 3 # 3 gold toads, when changed, please change in html_client as well

  def create
    raise BadRequestError.new('bad parameter(s)') if (params[:resource_stone].to_f + params[:resource_wood].to_f + params[:resource_fur].to_f) > 1.1
    raise ForbiddenError.new('negative value(s)') if (params[:resource_stone].to_f < 0.0) || (params[:resource_wood].to_f < 0.0) | (params[:resource_fur].to_f < 0.0)

    pool = current_character.resource_pool
    pool.update_resource_amount()
    sum = pool.resource_stone_amount + pool.resource_wood_amount + pool.resource_fur_amount*2

    # check if user has enough cash
    raise ForbiddenError.new('not enough cash') if pool.resource_cash_amount < EXCHANGE_FEE

    # check if user has enough capacity
    raise ForbiddenError.new('not enough capacity') if (params[:resource_stone].to_f*sum) > pool.resource_stone_capacity || (params[:resource_wood].to_f*sum) > pool.resource_wood_capacity || (params[:resource_fur].to_f*sum) > pool.resource_fur_capacity

    # change resources
    pool.resource_stone_amount = sum*params[:resource_stone].to_f
    pool.resource_wood_amount  = sum*params[:resource_wood].to_f
    pool.resource_fur_amount   = sum*params[:resource_fur].to_f
    pool.resource_cash_amount -= EXCHANGE_FEE

    # save new values
    pool.save
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
end
