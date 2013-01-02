class Action::Settlement::AbandonOutpostActionsController < ApplicationController
  def create

    raise BadRequestError.new('no current character') if current_character.nil?
	raise BadRequest.new('missing parameter(s)') if params[:abandon_outpost_action].nil? || params[:abandon_outpost_action][:settlement_id].blank?
	raise ForbiddenError.new('tried to abandon a foreign settlement.')   unless  settlement.owner == current_character
	raise ForbiddenError.new('tried to abandon a settlement with forbidden typ.')   unless  settlement.typ_id == 3
	
	neandertaler = Character::Character.find_by_id_or_identifier(1)
    settlement = Settlement::Settlement.find_by_id(params[:tax_rate_action][:settlement_id])
	
	current_character.change_name_transaction(neandertaler) #Übergabe an Neandertaler 
    
	
	
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end  
  
end

