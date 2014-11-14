require 'credit_shop'

class Action::Shop::GoogleVerifyOrderActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create

    order_id       = params['google_verify_order_action'] && params['google_verify_order_action']['order_id']
    product_id     = params['google_verify_order_action'] && params['google_verify_order_action']['product_id']
    payment_token  = params['google_verify_order_action'] && params['google_verify_order_action']['payment_token']

    if order_id.present? && product_id.present? && payment_token.present?
      transaction = Shop::GoogleMoneyTransaction.find_by_google_order_id(order_id)
      offer = Shop::GoogleCreditOffer.find_by_google_product_id(product_id)

      if transaction.blank? && offer.present?
        config = Google::AppConfig.the_app_config
        config.refresh_token_if_expired

        if config.access_token_valid?

          # Hack
          if Rails.env.production?

            query = {
                package_name: Google::AppConfig::PACKAGE_NAME,
                product_id: product_id,
                payment_token: payment_token,
                google_access_token: config.access_token,
            }

            google_response = HTTParty.get(
                'https://test1.wack-a-doo.de/game_server/google/proxy/verify_order',
                :query => query,
                :headers => { 'Accept' => 'application/json'},
                :verify => false
            )

            logger.debug "googe api response (via proxy): #{google_response}"
          else
            google_response = HTTParty.get(
                "https://www.googleapis.com/androidpublisher/v2/applications/#{Google::AppConfig::PACKAGE_NAME}/purchases/products/#{product_id}/tokens/#{payment_token}?access_token=#{config.access_token}",
                verify: false,
            )
            logger.debug "googe api response: #{google_response}"
          end

          if google_response.code === 200
            google_response = google_response.parsed_response
            google_response = JSON.parse(google_response) if google_response.is_a?(String)

            if google_response['kind'] === Google::AppConfig::RESPONSE_KIND && google_response['purchaseState'] === 0 && google_response['consumptionState'] === 0

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
                      google_order_id:      order_id,
                      google_payment_token: payment_token,
                      google_product_id:    product_id,
                      credits:              offer.amount,
                      processed_at:         Time.at(google_response['purchaseTimeMillis'].to_f/1000)
                  })

                  status = :ok
                else
                  status = :unprocessable_entity
                end
              else
                status = :unprocessable_entity
              end
            else
              status = :unprocessable_entity
            end
          else
            status = :unprocessable_entity
          end
        else
          status = :unprocessable_entity
        end
      else
        status = :forbidden
      end
    else
      status = :bad_request
    end

    respond_to do |format|
      format.json { render json: {status: status}, status: status }
    end
  end

end