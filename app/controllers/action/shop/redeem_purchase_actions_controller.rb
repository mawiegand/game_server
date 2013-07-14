class Action::Shop::RedeemPurchaseActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/shop/redeem_purchase_actions
  # POST /action/shop/redeem_purchase_actions.json
  def create
    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:action_redeem_purchase_action].nil? || params[:action_redeem_purchase_action][:purchase_id].blank?

    special_offer = Shop::SpecialOffer.find_by_external_offer_id(params[:action_redeem_purchase_action][:external_offer_id])
    raise NotFoundError.new ("special offer with offer id #{params[:action_redeem_purchase_action][:external_offer_id]} not Found.") if special_offer.nil?

    ActiveRecord::Base.transaction(:requires_new => true) do

      shop_special_offers_transaction = Shop::SpecialOffersTransaction.find_or_create_by_character_id_and_external_offer_id(current_character.id, special_offer.external_offer_id)
      shop_special_offers_transaction.lock!

      if shop_special_offers_transaction.purchase.nil?
        purchase = shop_special_offers_transaction.create_purchase({
          character_id: current_character.id,
          external_offer_id: special_offer.external_offer_id,
        })
      else
        purchase = shop_special_offers_transaction.purchase
      end

      if !purchase.redeemed? && !shop_special_offers_transaction.redeemed?
        purchase.special_offer.credit_to(current_character)
        purchase.redeemed_at = Time.now
        purchase.save!

        shop_special_offers_transaction.redeemed_at = Time.now
        shop_special_offers_transaction.save!
      end
    end
  end

end
