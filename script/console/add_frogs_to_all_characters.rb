#!/usr/bin/env ruby
#
# script for crediting golden frogs to all non deleted users
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

amount = 25

Fundamental::Character.non_npc.not_deleted.where('id > 1').order('id asc').each do |c|
  pool = c.resource_pool
  puts "#{c.id} #{c.name} #{pool.resource_cash_amount}"
  pool.update_resource_amount_atomically
  pool.add_resources_transaction({3 => amount})
end