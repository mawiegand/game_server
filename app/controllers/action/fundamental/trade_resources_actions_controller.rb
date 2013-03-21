class Action::Fundamental::TradeResourcesActionsController < ApplicationController
  layout 'action'
  before_filter :authenticate

  EXCHANGE_FEE  = 3 # 3 gold toads, when changed, please change in html_client as well

  def create
    pStone = params[:resource_stone].to_f
    pWood  = params[:resource_wood].to_f
    pFur   = params[:resource_fur].to_f
    
    raise ForbiddenError.new('negative value(s)') if pStone < 0.0 || pWood < 0.0 || pFur < 0.0
    raise ForbiddenError.new('is this user dumb?! Why would anybody want to get 0 ressources?!') if pStone == 0.0 && pWood == 0.0 && pFur == 0.0

    Fundamental::ResourcePool.transaction do
      pool = current_character.resource_pool.lock!
      pool.update_resource_amount_atomically
      sum = pool.resource_stone_amount + pool.resource_wood_amount + pool.resource_fur_amount
      remaining = sum - (pStone + pWood + pFur)

      # check if user has enough cash
      raise ForbiddenError.new('not enough cash') if pool.resource_cash_amount < EXCHANGE_FEE

      # check if transmitted sum is bigger than the sum of the resource pool
      raise ForbiddenError.new('sum is greater than sum from respool') if remaining < 0 
      
      # check if each resource is greater than it's maximum capacity
      raise ForbiddenError.new('stone is greater than it\'s capacity') if pStone > pool.resource_stone_capacity
      raise ForbiddenError.new('wood is greater than it\'s capacity')  if pWood > pool.resource_wood_capacity
      raise ForbiddenError.new('fur is greater than it\'s capacity')   if pFur > pool.resource_fur_capacity

      # dividing remaining by 3 will force us to check if the capacity is reached and dividing another time.
      # Doing this will increase complexity of the code too much that I decided to go the simple way.
      remainEach = remaining/3
      remaining -= remaining.to_i
      remainEach.to_i.times do
        pStone += 1.0 if pStone < pool.resource_stone_capacity 
        pWood  += 1.0 if pWood  < pool.resource_wood_capacity
        pFur   += 1.0 if pFur   < pool.resource_fur_capacity
      end

      # assigning the rest
      if pStone+remaining < pool.resource_stone_capacity
        pStone += remaining
      elsif pWood+remaining < pool.resource_wood_capacity
        pWood += remaining
      else
        pFur += remaining
      end

      # assign new resource values
      pool.resource_stone_amount = pStone 
      pool.resource_wood_amount  = pWood
      pool.resource_fur_amount   = pFur
      pool.resource_cash_amount -= EXCHANGE_FEE

      # save new values
      pool.save
    end
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
end
