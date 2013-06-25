class Action::Shop::RedeemPurchaseActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/shop/redeem_purchase_actions
  # POST /action/shop/redeem_purchase_actions.json
  def create
    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:action_redeem_purchase_action].nil? || params[:action_redeem_purchase_action][:purchase_id].blank?

    purchase = Shop::Purchase.find_by_id(params[:action_redeem_purchase_action][:purchase_id])

    raise NotFoundError.new ("purchase with id #{params[:action_redeem_purchase_action][:purchase_id]} not Found.") if purchase.nil?
    raise ForbiddenError.new('tried to redeem purchase of foreign character.') unless purchase.character == current_character
    raise ForbiddenError.new('tried to redeem purchase that is already redeemed.') unless purchase.redeemed?

    purchase.special_offer.credit_to(current_character)

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
end
