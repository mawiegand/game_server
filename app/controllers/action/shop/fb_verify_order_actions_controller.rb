require 'credit_shop'
require 'util/facebook'

class Action::Shop::FbVerifyOrderActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create

    offer_id       = params['fb_verify_order_action'] && params['fb_verify_order_action']['offer_id']
    payment_id     = params['fb_verify_order_action'] && params['fb_verify_order_action']['payment_id']
    signed_request = params['fb_verify_order_action'] && params['fb_verify_order_action']['signed_request']

    logger.debug "1"

    if !offer_id.blank? && !payment_id.blank? && !signed_request.blank?

      logger.debug "2"

      response = HTTParty.get("https://graph.facebook.com/#{payment_id}", :query => {access_token: "#{Facebook::AppConfig.the_app_config.app_id}|#{Facebook::AppConfig.the_app_config.app_secret}"})

      logger.debug "3"

      if response.code == 200

        logger.debug "4"

        parsed_response = response.parsed_response
        data = Util::FacebookManager.parse_signed_request(signed_request, Facebook::AppConfig.the_app_config.app_secret)

        if !data.nil?

          logger.debug "5"

          action   = parsed_response['actions'] && parsed_response['actions'][0]
          item_url = parsed_response['items'] && parsed_response['items'][0] && parsed_response['items'][0]['product']
          offer    = Shop::FbCreditOffer.find_by_id(offer_id)

          if action['status'] == 'completed' &&
              data['status'] == 'completed' &&
              !offer.nil? &&
              offer.url == item_url

            logger.debug "6"

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
              logger.debug "7"

              api_response = http_response.parsed_response
              api_response = JSON.parse(api_response) if api_response.is_a?(String)
              if api_response['resultCode'] === 0

                Shop::FbMoneyTransaction.create({
                  identifier:   current_character.identifier,
                  fb_user_id:   parsed_response['user'] && parsed_response['user']['id'],
                  fb_user_name: parsed_response['user'] && parsed_response['user']['name'],
                  payment_id:   payment_id,
                  fb_offer_id:  offer_id,
                  credits:      offer.amount,
                  amount:       action['amount'],
                  currency:     action['currency'],
                  country:      parsed_response['country'],
                  payout_foreign_exchange_rate: parsed_response['payout_foreign_exchange_rate'],
                  test:         parsed_response['test'],
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