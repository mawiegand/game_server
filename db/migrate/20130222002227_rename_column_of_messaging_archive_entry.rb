class RenameColumnOfMessagingArchiveEntry < ActiveRecord::Migration
  def change
    rename_column :messaging_archive_entries, :owner_id, :recipient_id
  end
end
