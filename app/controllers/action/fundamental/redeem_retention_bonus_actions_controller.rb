class Action::Fundamental::RedeemRetentionBonusActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/fundamental/redeem_retention_bonus_actions
  # POST /action/fundamental/redeem_retention_bonus_actions.json
  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('character cannot redeem retention bonus (yet)') unless current_character.can_redeem_retention_bonus?

    current_character.redeem_retention_bonus
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
end
