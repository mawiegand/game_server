require 'five_d/access_token'

module Shop::ShopHelper
  
  # get account of current user from payment provider
  def get_customer_account
    payment_get('/virtual_bank/accounts/self.json')
  end
  
  # post virtual_bank_transaction to payment provider for charging containing credit amount 
  def post_virtual_bank_transaction(virtual_bank_transaction)
    payment_post('/virtual_bank/transactions.json', {:virtual_bank_transaction => virtual_bank_transaction})
  end
  
  protected
    
    # http-post query to path on payment provider an return the parsed response  
    def payment_post(path, query = {})
      add_auth_token(query)
      
      # TODO change and test ':query' to ':body', otherwise all params will be transmitted vie the get query string
      
      HTTParty.post(GAME_SERVER_CONFIG['payment_provider_base_url'] + path, :query => query, :headers => header).parsed_response
    end

    # http-get query to path on payment provider an return the parsed response      
    def payment_get(path, query = {})
      add_auth_token(query)
      HTTParty.get(GAME_SERVER_CONFIG['payment_provider_base_url'] + path, :query => query, :headers => header).parsed_response
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
