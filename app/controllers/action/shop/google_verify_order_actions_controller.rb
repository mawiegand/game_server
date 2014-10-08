require 'credit_shop'

class Action::Shop::GoogleVerifyOrderActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create

    order_id       = params['google_verify_order_action'] && params['google_verify_order_action']['order_id']
    product_id     = params['google_verify_order_action'] && params['google_verify_order_action']['product_id']
    payment_token  = params['google_verify_order_action'] && params['google_verify_order_action']['payment_token']

    if !order_id.blank? && !product_id.blank? && !payment_token.blank?

      offer = Shop::GoogleCreditOffer.find_by_google_product_id(product_id)

      # call to google

      if !offer.nil?  # check google call

        transaction_data = {
            userID:      current_character.identifier,
            method:      'bytro',
            offerID:     '249',
            scaleFactor: offer.amount.to_s,
            tstamp:      Time.now.to_i.to_s,
            comment:     '1',
        }

        query = {
            eID:    'api',
            key:    CreditShop::BytroShop::KEY,
            action: 'processPayment',
            data:   CreditShop::BytroShop.encoded_data(transaction_data),
        }

        query = CreditShop::BytroShop.add_hash(query)
        http_response = HTTParty.post(CreditShop::BytroShop::URL_BASE, :query => query, :verify => false)

        if http_response.code === 200
          api_response = http_response.parsed_response
          api_response = JSON.parse(api_response) if api_response.is_a?(String)
          if api_response['resultCode'] === 0

            Shop::GoogleMoneyTransaction.create({
                                                identifier:           current_character.identifier,
                                                google_payment_token: payment_token,
                                                google_product_id:    product_id,
                                                credits:              offer.amount,
                                            })

            status = :ok
          else
            status = :unprocessable_entity
          end
        else
          status = :unprocessable_entity
        end
      else
        status = :bad_request
      end
    else
      status = :bad_request
    end

    respond_to do |format|
      format.json { render json: {a: :b}, status: status }
    end
  end

end