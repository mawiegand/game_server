#!/usr/bin/env ruby
#
# script for getting transactions from bytro shop

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

require 'base64'
require 'digest'
require 'cgi'
require 'active_record'
require 'httparty'
require 'json'

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
  b64 = base64_encoded_data.gsub(/[\n\r ]/,'')
  b64
end

def add_hash(query)
  hash_base = query[:key] + query[:action] + CGI.escape(query[:data]) + SHARED_SECRET
  query[:hash] = Digest::SHA1.hexdigest(hash_base)
  query
end



# get transactions  
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
    result =  {
      response_code: 'ok',
      response_data: {
        amount: api_response['result'],
      }
    }
    puts result.inspect
  else
    puts api_response.inspect
  end
else
  puts "error: #{http_response.code}"
end
  