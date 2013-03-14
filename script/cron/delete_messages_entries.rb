#!/usr/bin/env ruby
#
# Script for deleting old message entries
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

Rails.logger.info "DELETE MSG ENTRIES: Start deleting old message entries..."

message_deletion_intervall = GAME_SERVER_CONFIG['message_deletion_intervall'].days.ago

@report = {
  started_at:   Time.now,
  finished_at:  nil,
  
  deleted_inbox_entries: [],
  deleted_outbox_entries: [],
}

Rails.logger.info "DELETE MSG ENTRIES: Start deleting inbox entries..."

@inbox_entries = Messaging::InboxEntry.find(:all, :conditions => ["read = ? AND created_at <= ?", true, message_deletion_intervall])
@inbox_entries.each do |inbox_entry|
    puts inbox_entry.inspect
    @report[:deleted_inbox_entries] << inbox_entry
    inbox_entry.destroy
end

Rails.logger.info "DELETE MSG ENTRIES: Deleted #{@report[:deleted_inbox_entries].count} inbox entries..."
Rails.logger.info "DELETE MSG ENTRIES: Start deleting outbox entries..."

@outbox_entries = Messaging::OutboxEntry.find(:all, :conditions => ["created_at <= ?", message_deletion_intervall])
@outbox_entries.each do |outbox_entry|
    puts outbox_entry.inspect
    @report[:deleted_outbox_entries] << outbox_entry
    outbox_entry.destroy
end

Rails.logger.info "DELETE MSG ENTRIES: Deleted #{@report[:deleted_outbox_entries].count} outbox entries..."
Rails.logger.info "DELETE MSG ENTRIES: Email report."

@report[:finished_at]       = Time.now

Backend::MessageDeletionMailer.message_deletion_report(@report).deliver

Rails.logger.info "DELETE MSG ENTRIES: Finished all tasks."
