class Action::Trading::TradingCartsActionsController < ApplicationController
  
  before_filter :authenticate                                             # always need the user to authenticate
  before_filter :authorize_staff, :except => [:show, :create, :destroy]   # all other actions may only be accessed by staff users
  before_filter :deny_api,        :except => [:show, :create, :destroy]   # the api may only be used for those three actions
  
  # Provides a listing of all trading cart actions in the system. 
  # May only be accessed by staff users using the backend; the API is
  # completely locked out.
  #
  # GET /action/trading/trading_carts_actions
  def index
    raise ForbiddenError.new('Access to index of trading cart actions forbidden') unless admin? || staff?
    @action_trading_trading_carts_actions = Action::Trading::TradingCartsAction.paginate(:page => params[:page], :per_page => 50)    
    @paginate = true   

    respond_to do |format|
      format.html
    end 
  end

  # GET /action/trading/trading_carts_actions/1
  # GET /action/trading/trading_carts_actions/1.json
  def show
    @action_trading_trading_carts_action = Action::Trading::TradingCartsAction.find(params[:id])
  
    if backend_request?
      raise ForbiddenError.new('Only staff is authorized to see trades in backend.')   unless staff?
    else
      raise ForbiddenError.new('Access to trade forbidden.') unless @action_trading_trading_carts_action.sender_id == current_character.id || (@action_trading_trading_carts_action.recipient_id == current_character.id && !@action_trading_trading_carts_action.returning)
    end

    last_modified = @action_trading_trading_carts_action.updated_at

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @action_trading_trading_carts_action }
      end
    end
  end

  # GET /action/trading/trading_carts_actions/new
  def new
    @action_trading_trading_carts_action = Action::Trading::TradingCartsAction.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /action/trading/trading_carts_actions/1/edit
  def edit
    @action_trading_trading_carts_action = Action::Trading::TradingCartsAction.find(params[:id])
  end

  # POST /action/trading/trading_carts_actions
  # POST /action/trading/trading_carts_actions.json
  def create
    if backend_request?
      raise ForbiddenError.new('Only staff is authorized to create new trades in backend.')   unless staff?
      @action_trading_trading_carts_action = Action::Trading::TradingCartsAction.new(params[:action_trading_trading_carts_action])
      @success = @action_trading_trading_carts_action.save
    else
      raise BadRequestError.new("malformed request")                             unless params.has_key? :trading_carts_action      
      raise BadRequestError.new("recipient missing")                             unless params[:trading_carts_action].has_key? :recipient_name
      raise BadRequestError.new("sending settlement missing")                    unless params[:trading_carts_action].has_key? :settlement_id
      
      @recipient = Fundamental::Character.find_by_name_case_insensitive(params[:trading_carts_action][:recipient_name])
      raise NotFoundError.new('Unknown Recipient.')                              if @recipient.nil?
      raise ForbiddenError.new('Not allowed to send resources to oneself.')      if current_character.id == @recipient.id
      @starting_settlement = Settlement::Settlement.find(params[:trading_carts_action][:settlement_id])
      raise BadRequestError.new('Settlement does not exist')                     if @starting_settlement.nil?
      raise ForbiddenError.new('Trade not unlocked')                             if @starting_settlement.settlement_unlock_p2p_trade_count.nil? || @starting_settlement.settlement_unlock_p2p_trade_count < 1
      
      role = determine_access_role(@starting_settlement.owner_id, nil)    
      raise ForbiddenError.new("Tried to forge a trade from another character.") unless role == :owner || admin? || staff?
      
      raise BadRequestError.new('Target character has no home location to send the resources to.') if @recipient.home_location.nil?
      
      @target_settlement = @recipient.home_location.settlement
      raise BadRequestError.new('Target character has no home settlement.')      if @target_settlement.nil?
      
      start_time = Time.now

      @action_trading_trading_carts_action = Action::Trading::TradingCartsAction.new({
        sender_id:              current_character.id,
        recipient_id:           @recipient.id,
        starting_region_id:     @starting_settlement.region_id,
        target_region_id:       @target_settlement.region_id,
        target_reached_at:      start_time + 1.hours,
        returned_at:            start_time + 2.hours,
        starting_settlement_id: @starting_settlement.id,
        target_settlement_id:   @target_settlement.id
      })      
      
      GameRules::Rules.the_rules().resource_types.each do |resource_type|
        if resource_type[:tradable] == true 
          field_name = resource_type[:symbolic_id].to_s() + '_amount'
          @action_trading_trading_carts_action[field_name] = params[:trading_carts_action][field_name]  unless params[:trading_carts_action][field_name].blank?
        end
      end     
      
      @action_trading_trading_carts_action.num_carts = @action_trading_trading_carts_action.carts_needed
      
      ActiveRecord::Base.transaction do
        @action_trading_trading_carts_action.starting_settlement.lock!
        @action_trading_trading_carts_action.starting_settlement.trading_carts_used += @action_trading_trading_carts_action.num_carts
        raise ActiveRecord::Rollback  if @action_trading_trading_carts_action.starting_settlement.trading_carts_used > @action_trading_trading_carts_action.starting_settlement.trading_carts 
        raise ActiveRecord::Rollback  unless @action_trading_trading_carts_action.load_resources
        @action_trading_trading_carts_action.starting_settlement.save!    # throws rollback, if failed
        @action_trading_trading_carts_action.save!                        # throws rollback, if failed
        @action_trading_trading_carts_action.create_event
        @success = true
      end
    end
      
    respond_to do |format|
      if @success
        format.html { redirect_to @action_trading_trading_carts_action,         notice: 'Trading carts action was successfully created.' }
        format.json { render json: @action_trading_trading_carts_action,        status: :created, location: @action_trading_trading_carts_action }
      else
        format.html { render action: "new" }
        format.json { render json: @action_trading_trading_carts_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /action/trading/trading_carts_actions/1
  def update
    @action_trading_trading_carts_action = Action::Trading::TradingCartsAction.find(params[:id])    

    respond_to do |format|
      if @action_trading_trading_carts_action.update_attributes(params[:action_trading_trading_carts_action])
        format.html { redirect_to @action_trading_trading_carts_action, notice: 'Trading carts action was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /action/trading/trading_carts_actions/1
  # DELETE /action/trading/trading_carts_actions/1.json
  def destroy
    @action_trading_trading_carts_action = Action::Trading::TradingCartsAction.find(params[:id])
    
    if backend_request?
      raise ForbiddenError.new('Only staff is authorized to delete trades in backend.')   unless staff?
      @action_trading_trading_carts_action.destroy   # will automatically release the carts and destroy the event
    else
      role = determine_access_role(@action_trading_trading_carts_action.sender_id, nil)    
      raise ForbiddenError.new("Tried to stop a trade from another character.") unless role == :owner || admin? || staff?
      raise BadRequest.new("Tried to stop a trade that is already returning.")  if @action_trading_trading_carts_action.returning
      
      raise InternalServerError.new("Could not cancel trade.") unless @action_trading_trading_carts_action.cancel_transaction
    end

    respond_to do |format|
      format.html { redirect_to action_trading_trading_carts_actions_url }
      format.json { head :ok }
    end
  end
end
