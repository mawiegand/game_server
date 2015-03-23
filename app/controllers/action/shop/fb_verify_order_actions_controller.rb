require 'credit_shop'
require 'util/facebook'

class Action::Shop::FbVerifyOrderActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create

    offer_id       = params['fb_verify_order_action'] && params['fb_verify_order_action']['offer_id']
    payment_id     = params['fb_verify_order_action'] && params['fb_verify_order_action']['payment_id']
    signed_request = params['fb_verify_order_action'] && params['fb_verify_order_action']['signed_request']

    if offer_id.present? && payment_id.present? && signed_request.present?

      response = HTTParty.get("https://graph.facebook.com/#{payment_id}", :query => {access_token: "#{Facebook::AppConfig.the_app_config.app_id}|#{Facebook::AppConfig.the_app_config.app_secret}"})

      logger.info "fb api call response: #{response}"

      if response.code == 200

        parsed_response = response.parsed_response
        data = Util::FacebookManager.parse_signed_request(signed_request, Facebook::AppConfig.the_app_config.app_secret)

        logger.info "fb api call parsed response: #{parsed_response}"
        logger.info "parsed signed_request: #{data}"

        if !data.nil?

          action   = parsed_response['actions'] && parsed_response['actions'][0]
          item_url = parsed_response['items'] && parsed_response['items'][0] && parsed_response['items'][0]['product']
          offer    = Shop::FbCreditOffer.find_by_id(offer_id)

          logger.info "fb api call parsed response - action: #{action}, item_url: #{item_url}, offer: #{offer}"

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

            logger.info "transaction_data: #{transaction_data}, query: #{query}, bytro call http_response: #{http_response}"

            if http_response.code === 200

              api_response = http_response.parsed_response
              api_response = JSON.parse(api_response) if api_response.is_a?(String)

              logger.info "bytro api response: #{api_response}"

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

                logger.info "bytro api response resultCode: 0"
                status = :ok
              else
                logger.info "error 422: bytro api response resultCode: #{api_response['resultCode']}"
                status = :unprocessable_entity
              end
            else
              logger.error "error 422: http_response.code != 200 (code = #{http_response.code})"
              status = :unprocessable_entity
            end
          else
            logger.error "error 400: action[status] != completed or data[status] != completed or offer is invalid "
            status = :bad_request
          end
        else
          logger.error "error 400: data is nil"
          status = :bad_request
        end
      else
        logger.error "error 400: bad response"
        status = :bad_request
      end
    else
      logger.error "error 400: offer_id or payment_id or signed_request is blank"
      status = :bad_request
    end

    respond_to do |format|
      format.json { render json: {}, status: status }
    end
  end

end