#!/usr/bin/env ruby
#
# Helper script that makes all non-deleted characters insider.
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))

STDOUT.sync = true

puts
puts "This script makes all players insider."

 Fundamental::Character.non_npc.not_deleted.each do |character|
   if character.insider_since.nil?
     character.insider_since = DateTime.now
     character.save
     
     puts character.name
   end
 end

puts "Done."