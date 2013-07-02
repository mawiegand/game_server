#!/usr/bin/env ruby
#
# Export all characters with likes and dislikes as csv
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

STDOUT.sync = true

puts
puts "This script exports all players with likes and dislikes."

output_filename = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'tmp', 'likes.csv'))

File.open(output_filename, 'w') do |out|
  out.write("\"character_id\";\"sent_likes\";\"received_likes\";\"sent_dislikes\";\"received_dislikes\"\n")
  Fundamental::Character.non_npc.order('id asc').each do |c|
    out.write("#{c.id};#{c.send_likes_count};#{c.received_likes_count};#{c.send_dislikes_count};#{c.received_dislikes_count}\n")
  end
end

puts "Done."
