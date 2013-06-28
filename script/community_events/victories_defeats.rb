#!/usr/bin/env ruby
#
# Export all characters with victories and defeats as csv
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

STDOUT.sync = true

puts
puts "This script exports all players with victories and defeats."

output_filename = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'tmp', 'victories_defeats.csv'))

File.open(output_filename, 'w') do |out|
  out.write("\"character_id\";\"victories\";\"defeats\"\n")
  Fundamental::Character.non_npc.order('id asc').each do |c|
    out.write("#{c.id};#{c.victories};#{c.defeats}\n")
  end
end

puts "Done."