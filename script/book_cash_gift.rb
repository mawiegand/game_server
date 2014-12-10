#!/usr/bin/env ruby
# encoding: utf-8
#
# Helper script that books the three 15% resource bonuses to all characters
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))

STDOUT.sync = true

num_frogs = 25
RESOURCE_ID_CASH = 3

puts
puts "This script books #{ num_frogs } golden frogs to all characters."

Fundamental::Character.non_npc.not_deleted.order('id').each do |character|
  puts "character: #{character.id} #{character.name}"
  
  character.resource_pool.add_resource_atomically(RESOURCE_ID_CASH, num_frogs)
end

puts "Done."