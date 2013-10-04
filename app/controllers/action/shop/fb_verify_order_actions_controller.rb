require 'credit_shop'
require 'util/facebook'

class Action::Shop::FbVerifyOrderActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  FB_APP_ID        = '127037377498922'
  FB_APP_SECRET    = 'f88034e6df205b5aa3854e0b92638754'

  def create

    offer_id       = params['fb_verify_order_action'] && params['fb_verify_order_action']['offer_id']
    payment_id     = params['fb_verify_order_action'] && params['fb_verify_order_action']['payment_id']
    signed_request = params['fb_verify_order_action'] && params['fb_verify_order_action']['signed_request']

    if !offer_id.blank? && !payment_id.blank? && !signed_request.blank?

      response = HTTParty.get("https://graph.facebook.com/#{payment_id}", :query => {access_token: "#{FB_APP_ID}|#{FB_APP_SECRET}"})

      if response.code == 200

        parsed_response = response.parsed_response
        data = Util::Facebook.parse_signed_request(signed_request, FB_APP_SECRET)

        if !data.nil?

          action   = parsed_response['actions'] && parsed_response['actions'][0]
          item_url = parsed_response['items'] && parsed_response['items'][0] && parsed_response['items'][0]['product']
          offer    = Shop::FbCreditOffer.find_by_id(offer_id)

          if action['status'] == 'completed' &&
              data['status'] == 'completed' &&
              !offer.nil? &&
              offer.url == item_url

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
            http_response = HTTParty.post(CreditShop::BytroShop::URL_BASE, :query => query)

            if http_response.code === 200
              api_response = http_response.parsed_response
              api_response = JSON.parse(api_response) if api_response.is_a?(String)
              if api_response['resultCode'] === 0
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
      else
        status = :bad_request
      end
    else
      status = :bad_request
    end

    respond_to do |format|
      format.json { render json: {}, status: status }
    end
  end

end