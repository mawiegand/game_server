#!/usr/bin/env ruby
#
# script for destroying all diplomacy relations
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

diplomacy_relation_count = Fundamental::DiplomacyRelation.count
event_count = Event::Event.where("event_type = 'diplomacy_relation'").count

puts "Found #{diplomacy_relation_count} diplomacy relations."
puts "Found #{event_count} diplomacy relation events."

print 'Destroying all diplomacy relations... '

destroyed = Fundamental::DiplomacyRelation.destroy_all
puts 'done.'

destroyed_count = destroyed.length
event_count_after = Event::Event.where("event_type = 'diplomacy_relation'").count

if destroyed_count == diplomacy_relation_count && event_count_after == 0
  puts "Everything worked well. Destroyed #{destroyed_count} diplomacy relations."
else
  abort 'failed. Something went wrong.'
end