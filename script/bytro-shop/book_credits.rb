#!/usr/bin/env ruby
#
# script for booking credits to customer accounts at bytro shop

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))
require 'credit_shop/bytro_shop'

STDOUT.sync = true


###############################################################################
#
# identifier and booking amount
# if amount is positive, amount of user will increase

  identifier = 'deleteme'
  amount = -2

###############################################################################

# get character for output
character = Fundamental::Character.find_by_id_or_identifier(identifier)
name = character.nil? ? 'new user' : character.name

# get account balance
response = CreditShop::BytroShop.get_customer_account(identifier)

if response[:response_code] == Shop::Transaction::API_RESPONSE_OK
  puts "Old credit balance for user #{name} (#{identifier}): #{response[:response_data][:amount]}"
else
  puts "Could not get balance amount (Response Code: #{response[:response_code]})"
  exit 1
end


# book amount and get new balance
transaction = {
  customer_identifier: identifier,
  credit_amount_booked: -amount,
  booking_type: Shop::Transaction::TYPE_DEBIT,
  transaction_id: -1,
}

response = CreditShop::BytroShop.post_virtual_bank_transaction(transaction, identifier)

if response[:response_code] == Shop::Transaction::API_RESPONSE_OK
  puts "New credit balance for user #{name} (#{identifier}): #{response[:response_data][:amount]}"
else
  puts "Could not book amount of #{amount} credits (Response Code: #{response[:response_code]})"
  exit 1
end


