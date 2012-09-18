require 'five_d/access_token'

module CreditShop
  
  class FiveDPaymentProvider 
  
    include Auth::SessionsHelper

    def initialize(request_object)
      @request = request_object
    end
    
    def request
      @request
    end

    # get account of current user from payment provider
    def get_customer_account
      http_response = payment_get('/virtual_bank/accounts/self.json')
      
      if (http_response.code === 200)
        return {
          response_code: Shop::Transaction::API_RESPONSE_OK,
          response_data: {
            amount: http_response.parsed_response['amount'],
          }
        }
      else
        return {response_code: Shop::Transaction::API_RESPONSE_ERROR}
      end
    end
    
    # post virtual_bank_transaction to payment provider for charging containing credit amount 
    def post_virtual_bank_transaction(virtual_bank_transaction)
      http_response = payment_post('/virtual_bank/transactions.json', {:virtual_bank_transaction => virtual_bank_transaction})

      if (http_response.code === 201)
        api_response = http_response.parsed_response
        if (api_response['state'] === Shop::Transaction::STATE_COMMITTED)
          return {
            response_code: Shop::Transaction::API_RESPONSE_OK,
            response_data: {
              amount: api_response['credit_amount_after'],
            }
          }
        end
      end
      
      {response_code: Shop::Transaction::API_RESPONSE_ERROR}
    end
    
    protected
      
      # http-post query to path on payment provider an return the parsed response  
      def payment_post(path, query = {})
        add_auth_token(query)
        
        # TODO change and test ':query' to ':body', otherwise all params will be transmitted vie the get query string
        
        HTTParty.post(GAME_SERVER_CONFIG['payment_provider_base_url'] + path, :query => query, :headers => header)
      end
  
      # http-get query to path on payment provider an return the parsed response      
      def payment_get(path, query = {})
        add_auth_token(query)
        HTTParty.get(GAME_SERVER_CONFIG['payment_provider_base_url'] + path, :query => query, :headers => header)
      end
      
      # return auth header for request to payment provider
      def header
        { "Authorization" => 'Bearer ' + request_access_token.token }
      end
      
      # adds auth token to query hash for client authentication at payment provider
      def add_auth_token(query)
        if @auth_token.nil?
          @auth_token = FiveD::AccessToken.generate_access_token('wackadoo', ['payment'])
        end
        query[:auth_token] = @auth_token.token
      end
      
  end
end
