class Action::Fundamental::TradeResourcesActionsController < ApplicationController
  layout 'action'
  before_filter :authenticate

  EXCHANGE_FEE  = 3 # 3 gold toads, when changed, please change in html_client as well
  MAX_OVERFLOW  = 1.05 #percentage
  MAX_UNDERFLOW = 0.98

  def create
    #raise BadRequestError.new('bad parameter(s)') if (params[:resource_stone].to_f + params[:resource_wood].to_f + params[:resource_fur].to_f) > MAX_OVERFLOW
    #raise BadRequestError.new('bad parameter(s)') if (params[:resource_stone].to_f + params[:resource_wood].to_f + params[:resource_fur].to_f) < MAX_UNDERFLOW
    #raise ForbiddenError.new('negative value(s)') if (params[:resource_stone].to_f < 0.0) || (params[:resource_wood].to_f < 0.0) | (params[:resource_fur].to_f < 0.0)
    #
    #Fundamental::ResourcePool.transaction do
    #  pool = current_character.resource_pool.lock!
    #  pool.update_resource_amount_atomically
    #  sum = pool.resource_stone_amount + pool.resource_wood_amount + pool.resource_fur_amount
    #
    #  # check if user has enough cash
    #  raise ForbiddenError.new('not enough cash') if pool.resource_cash_amount < EXCHANGE_FEE
    #
    #  # check if user has enough capacity
    #  # TODO: need to check those values a bit more. due to the
    #  #       decimal places and rounding on the client side,
    #  #       the new values are higher that they should be.
    #  new_stone_value = sum*params[:resource_stone].to_f
    #  new_wood_value  = sum*params[:resource_wood].to_f
    #  new_fur_value   = sum*params[:resource_fur].to_f
    #
    #  #raise ForbiddenError.new("#{sum} #{params[:resource_stone].to_f} #{params[:resource_wood].to_f} #{params[:resource_fur].to_f}")
    #
    #  # due to the rounding in the client, it may happen that the capacity is exceeded, thus
    #  # we're checking if that happens and if it does wihting our inaccuracy limitation, we assign
    #  # the capacity to the value, ensuring that the user gets what he/she assigned.
    #  #
    #  # TODO: refactor here. 3 times the same step only with 1 difference.
    #  if new_stone_value > pool.resource_stone_capacity
    #    if new_stone_value > pool.resource_stone_capacity*MAX_OVERFLOW
    #      raise ForbiddenError.new('stone capacity exceeded')
    #    else
    #      new_stone_value = pool.resource_stone_capacity
    #    end
    #  end
    #
    #  if new_wood_value > pool.resource_wood_capacity
    #    if new_wood_value > pool.resource_wood_capacity*MAX_OVERFLOW
    #      raise ForbiddenError.new("wood capacity exceeded")
    #    else
    #      new_wood_value = pool.resource_wood_capacity
    #    end
    #  end
    #
    #  if new_fur_value > pool.resource_fur_capacity
    #    if new_fur_value > pool.resource_fur_capacity*MAX_OVERFLOW
    #      raise ForbiddenError.new('fur capacity exceeded')
    #    else
    #      new_fur_value = pool.resource_fur_capacity
    #    end
    #  end
    #
    #  # change resources
    #  pool.resource_stone_amount = new_stone_value.to_f
    #  pool.resource_wood_amount  = new_wood_value.to_f
    #  pool.resource_fur_amount   = new_fur_value.to_f
    #  pool.resource_cash_amount -= EXCHANGE_FEE
    #
    #  # save new values
    #  pool.save
    #end
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
end
