#!/usr/bin/env ruby
#
# script for getting transactions from bytro shop

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

require 'credit_shop/bytro_shop'

STDOUT.sync = true

shop = CreditShop::BytroShop.new(nil)
puts shop.get_money_transactions.inspect