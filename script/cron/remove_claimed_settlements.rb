#!/usr/bin/env ruby
#
# Script for deleting inactive players
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

puts "Remove claimed locations and big chiefs of players, that didn't found first settlement"

now = Time.now

@report = {
  started_at:   Time.now,
  finished_at:  nil,
  
  removed_not_started_players: [],
}

# get and delete all inactive player
removed_not_started_players = 0
Fundamental::Character.non_npc.not_started.each do |c|
  @report[:deleted_players] << c
  c.removed_not_started
  removed_not_started_players += 1
  print "."
  sleep(1)
end
puts ""

# send out status mail if necessary
if @report[:removed_not_started_players].count > 0
  puts "Remove claimed locations: mail report"
  @report[:finished_at] = now
  Backend::PlayerDeletionMailer.player_deletion_report(@report).deliver
end

puts "Remove claimed locations: finished cron job"
