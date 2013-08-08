class Action::Settlement::RedeemSlotBubbleActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:redeem_slot_bubble_action].nil? || params[:redeem_slot_bubble_action][:slot_id].blank?
    
    slot = Settlement::Slot.find_by_id(params[:redeem_slot_bubble_action][:slot_id])
    
    raise NotFoundError.new ("Slot with id #{params[:redeem_slot_bubble_action][:slot_id]} not Found.") if slot.nil?
    raise BadRequestError.new('slot has no settlement') if slot.settlement.nil?
    raise ForbiddenError.new('tried to change name of a foreign settlement.') if slot.settlement.owner != current_character

    slot.redeem_bubble
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
