#!/usr/bin/env ruby
#
# Export all characters with score as csv
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

STDOUT.sync = true

puts
puts "This script exports all players with score."

output_filename = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'tmp', 'resource_production.csv'))

File.open(output_filename, 'w') do |out|
  out.write("\"character_id\";\"resource_production\"\n")
  Ranking::CharacterRanking.order('character_id asc').each do |c|
    out.write("#{c.character_id};#{c.resource_score}\n")
  end
end

puts "Done."
