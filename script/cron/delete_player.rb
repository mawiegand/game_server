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
  deleted_settlements: [],
  shortly_before_deletable_players: [],
}

# get and delete all inactive player
Rails.logger.info "DELETE PLAYERS: deleting players"
Fundamental::Character.non_npc.deletable.each do |c|
  @report[:deleted_players] << c
  
  # call delete method of character
  # c.delete_from_game
end
Rails.logger.info "DELETE PLAYERS: finished deleting players"


# get all players that will become inactive through the next 24 hours
# and therefore will be deleted with next start of script 
Rails.logger.info "DELETE PLAYERS: fetching players becoming deletable"
Fundamental::Character.non_npc.shortly_before_deletable.each do |c|
  @report[:shortly_before_deletable_players] << c
end
Rails.logger.info "DELETE PLAYERS: finished fetching players becoming deletable"


# get and delete all inactive player
Rails.logger.info "DELETE PLAYERS: deleting unused npc settlements"
Fundamental::Character.npc.each do |c|
  c.outposts.each do |o|
    @report[:deleted_settlements] << o
    
    # call delete method of settlement
    # c.delete_from_game
  end

  c.bases.each do |b|
    @report[:deleted_settlements] << b
    
    # call delete method of settlement
    # c.delete_from_game
  end
end
Rails.logger.info "DELETE PLAYERS: finished deleting unused npc settlements"


# send out status mail if necessary
if @report[:deleted_players].count > 0 or @report[:shortly_before_deletable_players].count > 0 or @report[:deleted_settlements].count > 0
  Rails.logger.info "DELETE PLAYERS: mail report"
  @report[:finished_at] = Time.now
  Backend::PlayerDeletionMailer.player_deletion_report(@report).deliver
else
  Rails.logger.info "DELETE PLAYERS: mail report"
end

Rails.logger.info "DELETE PLAYERS: finished cron job"
