require 'base64'
require 'digest'

module CreditShop
  
  class BytroShop 
  
    include Auth::SessionsHelper
    
    URL_BASE = 'http://217.86.148.136/cl-5dshop/index.php'
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
      
      Rails.logger.debug '----------------------------------------------------------'
      Rails.logger.debug '----> ' + request_access_token.identifier
      Rails.logger.debug '----------------------------------------------------------'
      Rails.logger.debug data.inspect
      Rails.logger.debug data.to_param
      Rails.logger.debug encoded_data(data)
      Rails.logger.debug URL_BASE.inspect
      Rails.logger.debug query.inspect
      Rails.logger.debug query.to_param.inspect
      http_response = HTTParty.post(URL_BASE, :query => query)
      Rails.logger.debug http_response.inspect
      Rails.logger.debug http_response.parsed_response.inspect
      Rails.logger.debug '----------------------------------------------------------'
      
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
      
      Rails.logger.debug '----------------------------------------------------------'
      Rails.logger.debug URL_BASE.inspect
      Rails.logger.debug data.inspect
      Rails.logger.debug data.to_param
      Rails.logger.debug encoded_data(data)
      Rails.logger.debug query.inspect
      Rails.logger.debug query.to_param
      http_response = HTTParty.post(URL_BASE, :query => query)
      Rails.logger.debug http_response.inspect
      Rails.logger.debug http_response.parsed_response.inspect
      Rails.logger.debug '----------------------------------------------------------'
      
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
        Rails.logger.debug '1 ' + url_encoded_data.to_param
        base64_encoded_data = Base64.encode64(url_encoded_data.to_param)
        Rails.logger.debug '2 ' + base64_encoded_data
        b64 = base64_encoded_data.gsub(/[\n\r ]/,'')
        Rails.logger.debug '3 ' + b64
        b64
      end
      
      def add_hash(query)
        hash_base = query[:key] + query[:action] + CGI.escape(query[:data]) + SHARED_SECRET
        Rails.logger.debug '5 ' + hash_base.inspect
        query[:hash] = Digest::SHA1.hexdigest(hash_base)
        query
      end
  end
end
