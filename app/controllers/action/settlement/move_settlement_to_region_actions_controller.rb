class Action::Settlement::MoveSettlementToRegionActionsController < ApplicationController

  before_filter :authenticate

  def create
    
  	raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequest.new('missing parameter(s)') if params[:move_settlement_action].nil? || params[:move_settlement_action][:region_name].blank?
  	#raise ConflictError.new('already moved') unless current_character.moved_at.nil?
    
    region = Map::Region.find_by_name(params[:move_settlement_action][:region_name])
    #raise BadRequestError.new("moving is not allowed") unless region.is_moving_allowed?(current_character.alliance, '')
    old_base_location = Map::Location.find(current_character.base_location_id)

    home_base = Settlement::Settlement.find_by_location_id(current_character.base_location_id)
    raise BadRequestError.new("home_base is fighting") if home_base.fighting?
    home_base.move_settlement_to_region(region)
    current_character.base_location_id = home_base.location_id
    current_character.base_region_id = home_base.location.region_id
    current_character.base_node_id = home_base.location.region.node_id
    old_base_location.remove_settlement
    current_character.moved_at = Time.now
    current_character.save
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end  
  
end

