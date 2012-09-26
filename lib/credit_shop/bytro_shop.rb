require 'base64'
require 'digest'

module CreditShop
  
  class BytroShop 
  
    include Auth::SessionsHelper
    
    URL_BASE = 'https://secure.bytro.com/index.php'
    SHARED_SECRET = 'jfwjhgflhg254tp9824ghqlkgjh25pg8hgljkgh5896ogihdgjh24uihg9p8zgagjh2p895ghfsjgh312g09hjdfghj'
    KEY = 'wackadoo'
    
    # get account of current user
    def get_customer_account
      data = {
        userID: request_access_token.identifier,
      }
      
      query = {
        eID: 'api',
        key: KEY,
        action: 'walletGetAmount',
        data: encoded_data(data),
      }
      
      query = add_hash(query)
      http_response = HTTParty.post(URL_BASE, :query => query)
      
      if (http_response.code === 200)
        api_response = JSON.parse(http_response.parsed_response)
        if (api_response['resultCode'] === 0)
          return {
            response_code: Shop::Transaction::API_RESPONSE_OK,
            response_data: {
              amount: api_response['result']['amount'],
            }
          }
        end
      end
      
      # if any error occured  
      {response_code: Shop::Transaction::API_RESPONSE_ERROR}
    end
    
    # post virtual_bank_transaction to bytro shop for charging containing credit amount 
    def post_virtual_bank_transaction(virtual_bank_transaction)
      data = {
        userID: request_access_token.identifier,
        method:  'bytro',
        offerID: '54',
        scaleFactor: (-virtual_bank_transaction[:credit_amount_booked]).to_s,
        tstamp: Time.now.to_i.to_s,
        comment: Base64.encode64(virtual_bank_transaction[:transaction_id].to_s).gsub(/[\n\r ]/,'')  # Hack!
      }
      
      query = {
        eID:    'api',
        key:    KEY,
        action: 'processPayment',
        data:   encoded_data(data),
      }
      
      query = add_hash(query)
      http_response = HTTParty.post(URL_BASE, :query => query)
      
      if (http_response.code === 200)
        api_response = JSON.parse(http_response.parsed_response)
        if (api_response['resultCode'] === 0)
          return {
            response_code: Shop::Transaction::API_RESPONSE_OK,
            response_data: {
              amount: api_response['result']['amount'],
            }
          }
        elsif (api_response['resultCode'] === -1)
          return {response_code: Shop::Transaction::API_RESPONSE_USER_NOT_FOUND}
        end
      end
      
      # if any error occured  
      {response_code: Shop::Transaction::API_RESPONSE_ERROR}
    end
    
    # get account of current user
    def get_money_transactions
      query = {
        eID:    'api',
        key:    KEY,
        action: 'getTransactions',
        data: '',
      }
      
      query = add_hash(query)
      http_response = HTTParty.post(URL_BASE, :query => query)
      
      if (http_response.code === 200)
        api_response = JSON.parse(http_response.parsed_response)
        if (api_response['resultCode'] === 0)
          return {
            response_code: Shop::Transaction::API_RESPONSE_OK,
            response_data: {
              transactions: api_response['result'],
            }
          }
        end
      end
      
      # if any error occured  
      {response_code: Shop::Transaction::API_RESPONSE_ERROR}
    end
    
    # request object needed for SessionHelper
    def initialize(request_object)
      @request = request_object
    end
    
    # request object needed for SessionHelper
    def request
      @request
    end

    protected
    
      def encoded_data(data)
        url_encoded_data = {}
        data.each do |k, v|
          url_encoded_data[k] = CGI.escape(v)
        end
        base64_encoded_data = Base64.encode64(url_encoded_data.to_param)
        base64_encoded_data.gsub(/[\n\r ]/,'')
      end
      
      def add_hash(query)
        hash_base = query[:key] + query[:action] + CGI.escape(query[:data]) + SHARED_SECRET
        query[:hash] = Digest::SHA1.hexdigest(hash_base)
        query
      end
  end
end
