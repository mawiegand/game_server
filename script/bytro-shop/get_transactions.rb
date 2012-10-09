#!/usr/bin/env ruby
#
# script for getting transactions from bytro shop

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

require 'credit_shop/bytro_shop'

STDOUT.sync = true

shop = CreditShop::BytroShop.new(nil)
puts shop.get_money_transactions.inspect
puts shop.get_ingame_transactions.inspect

# {"uid"=>"67063026", 
 # "tstamp"=>"1349718356", 
 # "userID"=>"1991236", 
 # "invoiceID"=>"1991236.54.1349718356", 
 # "titleID"=>"231", 
 # "gameID"=>"0", 
 # "country"=>"DE", 
 # "offerID"=>"54", 
 # "optionID"=>"0", 
 # "offerCategory"=>"4", 
 # "gross"=>"-15", 
 # "grossCurrency"=>"5D Platinum Cre", 
 # "referrerID"=>"0", 
 # "chargeback"=>"0", 
 # "tutorial"=>"0", 
 # "tournamentID"=>"0", 
 # "transactionPayed"=>"1", 
 # "transactionState"=>"completed", 
 # "comment"=>"Credit wallet after payment 26939686", 
 # "scaleFactor"=>"1", 
 # "moneyTID"=>"26939686", 
 # "hash"=>"", 
 # "seed"=>"internal-wallet", 
 # "partnerUserID"=>"EOURvgETavTGtsqw"}