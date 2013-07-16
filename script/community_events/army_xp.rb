#!/usr/bin/env ruby
#
# Export all armies with character_id and xp as csv
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

STDOUT.sync = true

puts
puts "This script exports all armies with character_id."

output_filename = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'tmp', 'army_xp.csv'))

File.open(output_filename, 'w') do |out|
  out.write("\"army_id\";\"character_id\";\"xp\";\n")
  Military::Army.non_npc.non_garrison.order('id asc').each do |c|
    out.write("#{c.id};#{c.owner_id};#{c.exp};\n")
  end
end

puts "Done."
