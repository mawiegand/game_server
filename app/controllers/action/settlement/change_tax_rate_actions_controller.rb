class Action::Settlement::ChangeTaxRateActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequest.new('missing parameter(s)') if params[:tax_rate_action].nil? || params[:tax_rate_action][:tax_rate].blank? || params[:tax_rate_action][:settlement_id].blank?

    settlement = Settlement::Settlement.find_by_id(params[:tax_rate_action][:settlement_id])
    tax_rate = params[:tax_rate_action][:tax_rate].to_f
    
    raise NotFoundError.new ('Settlement with id #{params[:tax_rate_action][:settlement_id]} not Found.') if settlement.nil?
    raise ForbiddenError.new('tried to set tax rate on a foreign settlement.')   unless  settlement.owner == current_character
    raise BadRequestError.new('settlement does not own the region.')             unless settlement.owns_region?
    raise ForbiddenError.new ('tax rate out of range.')                          if tax_rate < 0.05 || tax_rate > 0.2
    raise ForbiddenError.new ('no tax rate change possible at the moment')       unless settlement.tax_rate_change_possible?

    settlement.tax_rate = tax_rate
    settlement.tax_changed_at = Time.now
    settlement.save
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end  
  
  
end
