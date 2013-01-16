#!/usr/bin/env ruby
#
# Script for deleting inactive players
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

Rails.logger.info "DELETE PLAYERS: start of cron job"

@report = {
  started_at:   Time.now,
  finished_at:  nil,
  
  deleted_players: [],
  players_getting_inactive: [],
}

# get and delete all inactive player
Rails.logger.info "DELETE PLAYERS: deleting players"
Fundamental::Character.non_npc.inactive.each do |c|
  @report[:deleted_players] << c
  
  # call delete method of character
  c.delete_from_game
end
Rails.logger.info "DELETE PLAYERS: finished deleting players"


# get all players that will become inactive through the next 24 hours
# and therefore will be deleted with next start of script 
Rails.logger.info "DELETE PLAYERS: fetching players getting inactive"
Fundamental::Character.non_npc.getting_inactive.each do |c|
  @report[:players_getting_inactive] << c
end
Rails.logger.info "DELETE PLAYERS: finished fetching players getting inactive"

# send out status mail if necessary
if @report[:deleted_players].count > 0 or @report[:players_getting_inactive].count > 0
  Rails.logger.info "DELETE PLAYERS: mail report"
  @report[:finished_at] = Time.now
  Backend::PlayerDeletionMailer.player_deletion_report(@report).deliver
else
  Rails.logger.info "DELETE PLAYERS: mail report"
end

Rails.logger.info "DELETE PLAYERS: finished cron job"





  
