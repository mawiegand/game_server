#!/usr/bin/env ruby
#
# Script for deleting inactive players
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

arg = ARGV[0].to_i unless ARGV[0].blank?
max_players = arg.nil? || arg === 0 ? 1 : arg

puts "DELETE PLAYERS: start of cron job, max: #{max_players}"

now = Time.now

@report = {
  started_at:   Time.now,
  finished_at:  nil,
  
  deleted_players: [],
  not_deleted_players: [],
  shortly_before_deletable_players: [],
  removed_settlements: [],
}

# get and delete all inactive player
print "DELETE PLAYERS: deleting players "

deleted_count = 0
Fundamental::Character.non_npc.deletable(now).each do |c|
  if deleted_count < max_players
    @report[:deleted_players] << c
    
    # call delete method of character
    c.delete_from_game 
    
    deleted_count += 1
    print "." 
    sleep(1)
  else
    @report[:not_deleted_players] << c
  end
end
puts ""
puts "DELETE PLAYERS: finished deleting players"


# get all players that will become inactive through the next 24 hours
# and therefore will be deleted with next start of script 
puts "DELETE PLAYERS: fetching players becoming deletable"
Fundamental::Character.non_npc.shortly_before_deletable(now).each do |c|
  @report[:shortly_before_deletable_players] << c
end
puts "DELETE PLAYERS: finished fetching players becoming deletable"


# get and remove all inactive npc settlements
print "DELETE PLAYERS: removing unused npc settlements "
Fundamental::Character.npc.each do |c|
  c.settlements.deletable(now).each do |s|
    @report[:removed_settlements] << s
    
    # call remove method of settlement
    # s.remove_from_map
  end

  print "." 
  sleep(1)
end
puts ""
puts "DELETE PLAYERS: finished removing unused npc settlements"


# send out status mail if necessary
if true || @report[:deleted_players].count > 0 or @report[:shortly_before_deletable_players].count > 0 or @report[:removed_settlements].count > 0
  puts "DELETE PLAYERS: mail report"
  @report[:finished_at] = now
  Backend::PlayerDeletionMailer.player_deletion_report(@report).deliver
else
  puts "DELETE PLAYERS: mail report"
end

puts "DELETE PLAYERS: finished cron job"
