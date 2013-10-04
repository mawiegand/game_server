require 'credit_shop'

class Action::Shop::FbVerifyOrderActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  FB_APP_ID        = '127037377498922'
  FB_APP_SECRET    = 'f88034e6df205b5aa3854e0b92638754'
  FB_CREDIT_AMOUNT = 30

  BYTRO_URL_BASE       = 'https://secure.bytro.com/index.php'
  BYTRO_SHARED_SECRET  = 'jfwjhgflhg254tp9824ghqlkgjh25pg8hgljkgh5896ogihdgjh24uihg9p8zgagjh2p895ghfsjgh312g09hjdfghj'
  BYTRO_KEY            = 'wackadoo'

  def create

    status = nil

    payment_id = params['fb_verify_order_action'] && params['fb_verify_order_action']['payment_id']
    signed_request = params['fb_verify_order_action'] && params['fb_verify_order_action']['signed_request']

    if !payment_id.blank? && !signed_request.blank?

      response = HTTParty.get("https://graph.facebook.com/#{payment_id}", :query => {access_token: "#{FB_APP_ID}|#{FB_APP_SECRET}"})

      if response.code == 200

        parsed_response = response.parsed_response
        action = parsed_response['actions'][0]

        if action['status'] == 'completed'

          data = {
              userID:      current_character.identifier,
              method:      'bytro',
              offerID:     '249',
              scaleFactor: FB_CREDIT_AMOUNT.to_s,
              tstamp:      Time.now.to_i.to_s,
              comment:     '1',
              # comment: Base64.encode64(virtual_bank_transaction[:transaction_id].to_s).gsub(/[\n\r ]/,'')  # Hack!
          }

          query = {
              eID:    'api',
              key:    CreditShop::BytroShop::KEY,
              action: 'processPayment',
              data:   CreditShop::BytroShop.encoded_data(data),
          }

          query = CreditShop::BytroShop.add_hash(query)
          http_response = HTTParty.post(CreditShop::BytroShop::URL_BASE, :query => query)

          if http_response.code === 200
            api_response = http_response.parsed_response
            api_response = JSON.parse(api_response) if api_response.is_a?(String)
            if api_response['resultCode'] === 0
              status = :ok
            end
          end
        end
      end
    end

    respond_to do |format|
      format.json { render json: {}, status: status }
    end
  end

end