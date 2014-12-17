#!/usr/bin/env ruby
#
# script for crediting construction effect to all non deleted users
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

duration = 96  # as hours
bonus = 0.25   # as factor

Fundamental::Character.non_npc.not_deleted.where('id > 1').order('id asc').each do |character|
  puts "#{character.id} #{character.name}"
  Effect::ConstructionEffect.create_temporary_custom_effect(character, bonus, duration)
  sleep(1)
end