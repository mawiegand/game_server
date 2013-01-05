class Action::Settlement::AbandonOutpostActionsController < ApplicationController

  before_filter :authenticate

  def create
    
  	raise BadRequestError.new('no current character') if current_character.nil?
  	raise BadRequest.new('missing parameter(s)') if params[:abandon_outpost_action].nil? || params[:abandon_outpost_action][:settlement_id].blank?
  	
    settlement = Settlement::Settlement.find_by_id(params[:abandon_outpost_action][:settlement_id])
  
  	raise ForbiddenError.new('tried to abandon a settlement with fighting garrison army')  if !settlement.garrison_army.nil? &&  settlement.garrison_army.fighting?
  	raise ForbiddenError.new('tried to abandon a foreign settlement')                      unless settlement.owner == current_character
  	raise ForbiddenError.new('tried to abandon a settlement with forbidden type')          unless settlement.type_id == Settlement::Settlement::TYPE_OUTPOST
  	
  	settlement.abandon_outpost
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end  
  
end

