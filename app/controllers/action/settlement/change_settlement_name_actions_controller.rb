class Action::Settlement::ChangeSettlementNameActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:settlement].nil? || params[:settlement][:name].blank?
    
    settlement = Settlement::Settlement.find_by_id(params[:settlement][:id])
    
    raise NotFoundError.new ('Settlement with id #{params[:settlement][:id]} not Found.') if settlement.nil?
    raise ForbiddenError.new('tried to change name of a foreign settlement.')   unless  settlement.owner == current_character
    
    settlement.change_name_transaction(params[:settlement][:name].strip) 
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
