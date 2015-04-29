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

  deleted_inactive_players: [],
  not_deleted_inactive_players: [],
  shortly_before_deletable_inactive_players: [],

  removed_settlements: [],
}

# get and delete all players who only logged in once
print "DELETE PLAYERS: deleting inactive players"

deleted_count = 0
Fundamental::Character.non_npc.deletable_inactive(now).each do |c|
  if deleted_count < max_players
    @report[:deleted_inactive_players] << c
    
    # call delete method of character
    # c.delete_from_game
    
    deleted_count += 1
    print "." 
    sleep(1)
  else
    @report[:not_deleted_inactive_players] << c
  end
end
puts ""
puts "DELETE PLAYERS: finished deleting inactive players"


# get and delete all inactive player
print "DELETE PLAYERS: deleting active players "

deleted_count = 0
Fundamental::Character.non_npc.deletable(now).each do |c|
  if deleted_count < max_players &&
      !c.last_retention_mail.nil? &&
      c.last_retention_mail.mail_type == 'getting_deleted' &&
      c.last_retention_mail.created_at < Time.now.advance(:days => -1)
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
puts "DELETE PLAYERS: finished deleting active players"


# get all players that will become inactive through the next 24 hours
# and therefore will be deleted with next start of script
puts "DELETE PLAYERS: fetching inactive players becoming deletable"
Fundamental::Character.non_npc.shortly_before_deletable_inactive(now).each do |c|
  @report[:shortly_before_deletable_inactive_players] << c
end
puts "DELETE PLAYERS: finished fetching inactive players becoming deletable"


# get all players that will become inactive through the next 24 hours
# and therefore will be deleted with next start of script 
puts "DELETE PLAYERS: fetching active players becoming deletable"
Fundamental::Character.non_npc.shortly_before_deletable(now).each do |c|
  @report[:shortly_before_deletable_players] << c
end
puts "DELETE PLAYERS: finished fetching active players becoming deletable"


# get and remove all inactive npc settlements
print "DELETE PLAYERS: removing unused npc settlements "
Fundamental::Character.npc.each do |c|
  c.settlements.deletable(now).each do |s|
    unless s.fighting?
      @report[:removed_settlements] << s

      # call remove method of settlement
      s.remove_from_map
    end
  end

  print "." 
  sleep(1)
end
puts ""
puts "DELETE PLAYERS: finished removing unused npc settlements"


# send out status mail if necessary
if @report[:deleted_players].count > 0 or
    @report[:deleted_inactive_players].count > 0 or
    @report[:shortly_before_deletable_players].count > 0 or
    @report[:shortly_before_deletable_inactive_players].count > 0 or
    @report[:removed_settlements].count > 0
  puts "DELETE PLAYERS: mail report"
  @report[:finished_at] = now
  Backend::PlayerDeletionMailer.player_deletion_report(@report).deliver
else
  puts "DELETE PLAYERS: no mail report"
end

puts "DELETE PLAYERS: finished cron job"
