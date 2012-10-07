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
        elsif (api_response['resultCode'] === -1)
          return {
            response_code: Shop::Transaction::API_RESPONSE_OK,
            response_data: {
              amount: 0,
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
      data = {
        startTstamp: Time.now.weeks_ago(4).to_i.to_s,
      }
      
      query = {
        eID:    'api',
        key:    KEY,
        action: 'getTransactions',
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
              transactions: api_response['result'],
            }
          }
        end
      end
      
      # if any error occured  
      {response_code: Shop::Transaction::API_RESPONSE_ERROR}
    end
    
    def update_money_transactions
      response = self.get_money_transactions
      
      if response[:response_code] === Shop::Transaction::API_RESPONSE_OK
        transactions = response[:response_data][:transactions]
        
        transactions.each do |transaction|
          uid = transaction['uid'].to_i
          if uid > 0
            money_transaction = Shop::MoneyTransaction.find_or_initialize_by_uid(uid)
      
            money_transaction.uid = uid 
            money_transaction.tstamp = transaction['tstamp'].to_i
            money_transaction.updatetstamp = transaction['updateTstamp']
            money_transaction.user_id = transaction['userID'].to_i
            money_transaction.invoice_id = transaction['invoiceID']
            money_transaction.title_id = transaction['titleID']
            money_transaction.method = transaction['method']
            money_transaction.carrier = transaction['carrier']
            money_transaction.country = transaction['country']
            money_transaction.offer_id = transaction['offerID'].to_i
            money_transaction.offer_category = transaction['offerCategory']
            money_transaction.gross = transaction['gross'].to_d
            money_transaction.gross_currency = transaction['grossCurrency'] 
            money_transaction.exchange_rate = transaction['exchangeRate'].to_f
            money_transaction.vat = transaction['vat'].to_f
            money_transaction.tax = transaction['tax'].to_f
            money_transaction.net = transaction['net'].to_f
            money_transaction.fee = transaction['fee'].to_f
            money_transaction.ebp = transaction['ebp'].to_f
            money_transaction.referrer_id = transaction['referrerID'] 
            money_transaction.referrer_share = transaction['referrerShare'].to_f
            money_transaction.earnings = transaction['earnings'].to_f
            money_transaction.chargeback = transaction['chargeback'].to_f
            money_transaction.campaign_id = transaction['campaignID']
            money_transaction.transaction_payed = transaction['transactionPayed'] == '1'
            money_transaction.transaction_state = transaction['transactionState']
            money_transaction.comment = transaction['comment']
            money_transaction.scale_factor = transaction['scaleFactor']
            money_transaction.user_mail = transaction['userMail']
            money_transaction.payment_transaction_uid = transaction['paymentTransactionUid'] 
            money_transaction.payment_state = transaction['paymentState']
            money_transaction.payment_state_reason = transaction['paymentStateReason']
            money_transaction.payer_id = transaction['payerID']
            money_transaction.payer_first_name = transaction['payerFirstName'] 
            money_transaction.payer_last_name = transaction['payerLastName']
            money_transaction.payer_mail = transaction['payerMail']
            money_transaction.payer_zip = transaction['payerZip']
            money_transaction.payer_city = transaction['payerCity']
            money_transaction.payer_street = transaction['payerStreet']
            money_transaction.payer_country = transaction['payerCountry']
            money_transaction.payer_state = transaction['payerState']
            money_transaction.hash = transaction['hash']
            money_transaction.seed = transaction['seed']
            money_transaction.partner_user_id = transaction['partnerUserID']
      
            money_transaction.save
            
            # update timestamp even if transaction is unchanged
            money_transaction.touch      
          end
        end
      end
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
