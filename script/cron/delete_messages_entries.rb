#!/usr/bin/env ruby
#
# Script for deleting old message entries
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

Rails.logger.info "DELETE MSG ENTRIES: Start deleting old message entries..."

oldest_message = GAME_SERVER_CONFIG['message_deletion_intervall'].days.ago

@report = {
  started_at:   Time.now,
  finished_at:  nil,

  deleted_inbox_entry_count: [],
  deleted_outbox_entry_count: [],
}

Rails.logger.info "DELETE MSG ENTRIES: Start deleting inbox entries..."

@inbox_entries = Messaging::InboxEntry.where("read = ? AND created_at <= ?", true, oldest_message)
@report[:deleted_inbox_entry_count] = @inbox_entries.count
@inbox_entries.destroy_all

Rails.logger.info "DELETE MSG ENTRIES: Deleted #{@report[:deleted_inbox_entry_count]} inbox entries..."
Rails.logger.info "DELETE MSG ENTRIES: Start deleting outbox entries..."

@outbox_entries = Messaging::OutboxEntry.where("created_at <= ?", oldest_message)
@report[:deleted_outbox_entry_count] = @outbox_entries.count
@outbox_entries.destroy_all

Rails.logger.info "DELETE MSG ENTRIES: Deleted #{@report[:deleted_outbox_entry_count]} outbox entries..."
Rails.logger.info "DELETE MSG ENTRIES: Email report."

@report[:finished_at]       = Time.now

Backend::MessageDeletionMailer.message_deletion_report(@report).deliver

Rails.logger.info "DELETE MSG ENTRIES: Finished all tasks."
