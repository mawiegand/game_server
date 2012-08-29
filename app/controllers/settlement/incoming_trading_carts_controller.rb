class Settlement::IncomingTradingCartsController < ApplicationController
  
  before_filter :authenticate
  
  def index
    last_modified = nil
    
    role = :default # assume lowest possible role
    
    raise BadRequest.new ("Settlement id missing in call.")   if params[:settlement_id].blank?
    
    @settlement = Settlement::Settlement.find(params[:settlement_id])
    raise NotFoundError.new('Settlement not found.') if @settlement.nil?
    role = determine_access_role(@settlement.owner_id, nil)   # no privileged alliance access
    raise ForbiddenError.new('Access to ongoing trading cart movements in given settlement denied.') unless role == :owner || admin? || staff?
    @action_trading_trading_carts_actions = @settlement.incoming_trading_carts || []
    @action_trading_trading_carts_actions.each { |entry| last_modified = entry.updated_at   if last_modified.nil? || entry.updated_at > last_modified } 

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
        end
        format.json do
          render json: @action_trading_trading_carts_actions
        end
      end   
    end 
  end
  
end
