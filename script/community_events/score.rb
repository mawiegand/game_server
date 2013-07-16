#!/usr/bin/env ruby
#
# Export all characters with score as csv
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

STDOUT.sync = true

puts
puts "This script exports all players with score."

output_filename = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'tmp', 'score.csv'))

File.open(output_filename, 'w') do |out|
  out.write("\"character_id\";\"score\"\n")
  Fundamental::Character.non_npc.order('id asc').each do |c|
    out.write("#{c.id};#{c.score}\n")
  end
end

puts "Done."
