#!/usr/bin/env ruby
# encoding: utf-8
#
# Helper script that books the three 15% resource bonuses to all characters
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))

STDOUT.sync = true

puts
puts "This script books the three 15% resource bonuses to all characters."

bonus1 = Shop::BonusOffer.find(1)
bonus2 = Shop::BonusOffer.find(2)
bonus3 = Shop::BonusOffer.find(3)

Fundamental::Character.non_npc.not_deleted.order('id').each do |character|
  puts "character: #{character.id} #{character.name}"
  puts "  bonuses before:"
  character.resource_pool.resource_effects.each do |e|
    puts "    #{e.resource_id} #{e.finished_at}"
  end
  puts "  book bonuses:"
  bonus1.credit_to(character)
  bonus2.credit_to(character)
  bonus3.credit_to(character)
  puts "  bonuses after:"
  character.resource_pool.resource_effects.reload
  character.resource_pool.resource_effects.each do |e|
    puts "    #{e.resource_id} #{e.finished_at}"
  end
end

puts "Done."