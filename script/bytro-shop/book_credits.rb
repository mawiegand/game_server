#!/usr/bin/env ruby
#
# script for booking credits to customer accounts at bytro shop

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

require 'base64'
require 'digest'
require 'cgi'
require 'httparty'
require 'json'
require 'five_d/access_token'
require 'credit_shop/bytro_shop'

STDOUT.sync = true

URL_BASE = 'https://secure.bytro.com/index.php'
SHARED_SECRET = 'jfwjhgflhg254tp9824ghqlkgjh25pg8hgljkgh5896ogihdgjh24uihg9p8zgagjh2p895ghfsjgh312g09hjdfghj'
KEY = 'wackadoo'


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

###############################################################################
#
# identifier and booking amount
# if amount is positive, amount of user will increase

identifier = 'IDBILitHCIsGwdWb'
amount = 100

###############################################################################




puts "book amount of #{amount} credits to account of user with identity #{identifier}"


# simulate shop access to create user at bytro shop
access_token = FiveD::AccessToken.generate_access_token(identifier, ['5dentity', 'wackadoo', 'payment'])
query = {
  eID: 'api',
  key: 'wackadooShop',
  action: 'openPartnerShop',
  hash: access_token.token,
}

http_response = HTTParty.post(URL_BASE, :query => query)


# get current acount balance of user
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

if (http_response.code === 200)
  api_response = JSON.parse(http_response.parsed_response)
  if (api_response['resultCode'] === 0)
    result =  {
      response_code: 'ok',
      response_data: {
        amount: api_response['result']['amount'],
      }
    }
    puts result.inspect
  else
    puts api_response.inspect
  end
else
  puts "error: #{http_response.code}"
end
  
  
# book given amount to user account
data = {
  userID: identifier,
  method:  'bytro',
  scaleFactor: (amount).to_s,
  tstamp: Time.now.to_i.to_s,
  comment: Base64.encode64('1').gsub(/[\n\r ]/,'')  # Hack!
}

if amount > 0
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

if (http_response.code === 200)
  api_response = JSON.parse(http_response.parsed_response)
  if (api_response['resultCode'] === 0)
    result =  {
      response_code: 'ok',
      response_data: {
        amount: api_response['result']['amount'],
      }
    }
    puts result.inspect
  else
    puts api_response.inspect
  end
else
  puts "error: #{http_response.code}"
end