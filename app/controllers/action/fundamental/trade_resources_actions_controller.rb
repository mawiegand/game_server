class Action::Fundamental::TradeResourcesActionsController < ApplicationController
  layout 'action'
  before_filter :authenticate

  def create
    p_stone = params[:resource_stone].to_f
    p_wood  = params[:resource_wood].to_f
    p_fur   = params[:resource_fur].to_f
    
    raise ForbiddenError.new('negative value(s)') if p_stone < 0.0 || p_wood < 0.0 || p_fur < 0.0

    Fundamental::ResourcePool.transaction do
      pool = current_character.resource_pool.lock!
      pool.update_resource_amount_atomically
      pool.reload
      sum = pool.resource_stone_amount + pool.resource_wood_amount + pool.resource_fur_amount
      remaining = sum - (p_stone + p_wood + p_fur)

      cost = GameRules::Rules.the_rules.resource_exchange
      price = { cost[:resource_id] => cost[:amount] }

      # check if user has enough cash
      raise ConflictError.new('not enough cash') unless pool.have_at_least_resources(price)

      # check if transmitted sum is bigger than the sum of the resource pool
      raise ForbiddenError.new('sum is greater than sum from respool') if remaining < 0 
      
      # check if each resource is greater than it's maximum capacity
      raise ForbiddenError.new('stone is greater than it\'s capacity') if p_stone > pool.resource_stone_capacity
      raise ForbiddenError.new('wood is greater than it\'s capacity')  if p_wood > pool.resource_wood_capacity
      raise ForbiddenError.new('fur is greater than it\'s capacity')   if p_fur > pool.resource_fur_capacity

      # dividing remaining by 3 will force us to check if the capacity is reached and dividing another time.
      # Doing this will increase complexity of the code too much that I decided to go the simple way.
      remain_each = remaining / 3
      p_stone += remain_each
      p_wood  += remain_each
      p_fur   += remain_each


      overfill_stone = p_stone - pool.resource_stone_capacity
      if overfill_stone > 0
        to_wood  = [overfill_stone / 2, pool.resource_wood_capacity - p_wood].min
        p_stone  = pool.resource_stone_capacity
        p_wood  += to_wood
        p_fur   += overfill_stone - to_wood
      end

      overfill_wood = p_wood - pool.resource_wood_capacity
      if overfill_wood > 0
        to_fur   = [overfill_wood / 2, pool.resource_fur_capacity - p_fur].min
        p_wood   = pool.resource_wood_capacity
        p_fur   += to_fur
        p_stone += overfill_wood - to_fur
      end

      overfill_fur = p_fur - pool.resource_fur_capacity
      if overfill_fur > 0
        to_stone = [overfill_fur / 2, pool.resource_stone_capacity - p_stone].min
        p_fur    = pool.resource_fur_capacity
        p_stone += to_stone
        p_wood  += overfill_fur - to_stone
      end

      # assign new resource values
      if pool.resource_stone_amount > p_stone.ceil || pool.resource_wood_amount > p_wood.ceil || pool.resource_fur_amount > p_fur.ceil
        pool.resource_stone_amount = p_stone.ceil
        pool.resource_wood_amount  = p_wood.ceil
        pool.resource_fur_amount   = p_fur.ceil
        pool.resource_cash_amount -= cost[:amount]

        # save new values
        pool.save
      end
    end
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
end
