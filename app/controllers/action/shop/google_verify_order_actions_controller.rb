require 'credit_shop'
require 'util/facebook'

class Action::Shop::GoogleVerifyOrderActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create

    order_id       = params['google_verify_order_action'] && params['google_verify_order_action']['order_id']
    product_id     = params['google_verify_order_action'] && params['google_verify_order_action']['product_id']
    payment_token  = params['google_verify_order_action'] && params['google_verify_order_action']['payment_token']

    status = :ok

    respond_to do |format|
      format.json { render json: {}, status: status }
    end
  end

end