require 'base64'
require 'digest'

module CreditShop
  
  class BytroShop 
  
    include Auth::SessionsHelper
    
    URL_BASE = 'https://secure.bytro.com/index.php'
    SHARED_SECRET = 'jfwjhgflhg254tp9824ghqlkgjh25pg8hgljkgh5896ogihdgjh24uihg9p8zgagjh2p895ghfsjgh312g09hjdfghj'
    KEY = 'wackadoo'
    
    # get account of current user
    def self.get_customer_account(identifier)
      data = {
        userID: identifier,
      }
      
      query = {
        eID: 'api',
        key: KEY,
        action: 'walletGetAmount',
        data: encoded_data(data),
      }
      
      query = add_hash(query)
      http_response = HTTParty.post(URL_BASE, :query => query)
      
      if http_response.code === 200
        api_response = http_response.parsed_response
        api_response = JSON.parse(api_response) if api_response.is_a?(String)
        if api_response['resultCode'] === 0
          return {
            response_code: Shop::Transaction::API_RESPONSE_OK,
            response_data: {
              amount: api_response['result']['amount'],
            }
          }
        elsif api_response['resultCode'] === -1
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
    def self.post_virtual_bank_transaction(virtual_bank_transaction, identifier)
      data = {
        userID: identifier,
        method:  'bytro',
        scaleFactor: (-virtual_bank_transaction[:credit_amount_booked]).to_s,
        tstamp: Time.now.to_i.to_s,
        comment: Base64.encode64(virtual_bank_transaction[:transaction_id].to_s).gsub(/[\n\r ]/,'')  # Hack!
      }
      
      if virtual_bank_transaction[:credit_amount_booked] < 0
        data[:offerID] = '249'
      else
        data[:offerID] = '248'
      end
      
      query = {
        eID:    'api',
        key:    KEY,
        action: 'processPayment',
        data:   encoded_data(data),
      }
      
      query = add_hash(query)
      http_response = HTTParty.post(URL_BASE, :query => query)
      
      if http_response.code === 200
        api_response = http_response.parsed_response
        api_response = JSON.parse(api_response) if api_response.is_a?(String)
        if api_response['resultCode'] === 0
          return {
            response_code: Shop::Transaction::API_RESPONSE_OK,
            response_data: {
              amount: api_response['result']['amount'],
            }
          }
        elsif api_response['resultCode'] === -1
          return {response_code: Shop::Transaction::API_RESPONSE_USER_NOT_FOUND}
        end
      end
      
      # if any error occured  
      {response_code: Shop::Transaction::API_RESPONSE_ERROR}
    end
    
    def self.get_money_transactions
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
      
      if http_response.code === 200
        api_response = http_response.parsed_response
        api_response = JSON.parse(api_response) if api_response.is_a?(String)
        if api_response['resultCode'] === 0
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
    
    def self.update_money_transactions
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
      
            # update timestamp even if transaction is unchanged
            money_transaction.touch
            money_transaction.save

            money_transaction.send_chargeback_alert    if money_transaction.unsent_chargeback_alert?
            money_transaction.send_special_offer_alert if money_transaction.unsent_special_offer_alert?
          end
        end
      end
    end
    
    def self.get_ingame_transactions
      data = {
        startTstamp: Time.now.advance(:days => -3).to_i.to_s,
        mode: 'ingame',
      }
      
      query = {
        eID:    'api',
        key:    KEY,
        action: 'getTransactions',
        data: encoded_data(data),
      }
      
      query = add_hash(query)
      http_response = HTTParty.post(URL_BASE, :query => query)
      
      if http_response.code === 200
        api_response = http_response.parsed_response
        api_response = JSON.parse(api_response) if api_response.is_a?(String)
        if api_response['resultCode'] === 0
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
    
    def self.update_ingame_transactions
      response = self.get_ingame_transactions
      
      if response[:response_code] === Shop::Transaction::API_RESPONSE_OK
        transactions = response[:response_data][:transactions]
        
        transactions.each do |transaction|
          uid = transaction['uid'].to_i
          if uid > 0
            credit_transactions = Shop::CreditTransaction.find_or_initialize_by_uid(uid)
      
            credit_transactions.uid = uid 
            credit_transactions.tstamp = transaction['tstamp'].to_i
            credit_transactions.user_id = transaction['userID'].to_i
            credit_transactions.invoice_id = transaction['invoiceID']
            credit_transactions.title_id = transaction['titleID']
            credit_transactions.game_id = transaction['gameID']
            credit_transactions.country = transaction['country']
            credit_transactions.offer_id = transaction['offerID'].to_i
            credit_transactions.option_id = transaction['optionID']
            credit_transactions.offer_category = transaction['offerCategory']
            credit_transactions.gross = transaction['gross'].to_d
            credit_transactions.gross_currency = transaction['grossCurrency'] 
            credit_transactions.referrer_id = transaction['referrerID'] 
            credit_transactions.chargeback = transaction['chargeback'].to_f
            credit_transactions.tutorial = transaction['tutorial'] == '1'
            credit_transactions.tournament_id = transaction['tournamentID']
            credit_transactions.transaction_payed = transaction['transactionPayed'] == '1'
            credit_transactions.transaction_state = transaction['transactionState']
            credit_transactions.comment = transaction['comment']
            credit_transactions.scale_factor = transaction['scaleFactor'].to_f
            credit_transactions.money_tid = transaction['moneyTID'].to_i
            credit_transactions.hash = transaction['hash']
            credit_transactions.seed = transaction['seed']
            credit_transactions.partner_user_id = transaction['partnerUserID']
      
            # update timestamp even if transaction is unchanged
            credit_transactions.touch      
            
            credit_transactions.save
          end
        end
      end
    end
    
    protected
    
      def self.encoded_data(data)
        url_encoded_data = {}
        data.each do |k, v|
          url_encoded_data[k] = CGI.escape(v)
        end
        base64_encoded_data = Base64.encode64(url_encoded_data.to_param)
        base64_encoded_data.gsub(/[\n\r ]/,'')
      end
      
      def self.add_hash(query)
        hash_base = query[:key] + query[:action] + CGI.escape(query[:data]) + SHARED_SECRET
        query[:hash] = Digest::SHA1.hexdigest(hash_base)
        query
      end
  end
end
