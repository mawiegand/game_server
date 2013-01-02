class Action::Settlement::AbandonOutpostActionsController < ApplicationController

  before_filter :authenticate

  def create
    
  	raise BadRequestError.new('no current character') if current_character.nil?
  	raise BadRequest.new('missing parameter(s)') if params[:abandon_outpost_action].nil? || params[:abandon_outpost_action][:settlement_id].blank?
  	
  	neandertaler = Fundamental::Character.find_by_id(1)
    settlement = Settlement::Settlement.find_by_id(params[:abandon_outpost_action][:settlement_id])
  
  	raise ForbiddenError.new('tried to abandon a foreign settlement.')   unless  settlement.owner == current_character
  	raise ForbiddenError.new('tried to abandon a settlement with forbidden typ.')   unless  settlement.type_id == Settlement::Settlement::TYPE_OUTPOST
  	
  	settlement.slots.each do |slot|
  	  if slot.slot_num == 1 && !slot.level.nil? && slot.level > 1
        slot.donwgrade_building
  	  elsif slot.slot_num == 2
  	    slot.destroy_building
  	  elsif slot.slot_num > 2
        slot.donwgrade_building
  	  end
  	end
  	
  	settlement.new_owner_transaction(neandertaler) #Uebergabe an Neandertaler 
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end  
  
end

