class RenameAnotherColumnOfMessagingArchiveEntry < ActiveRecord::Migration
  def change
    rename_column :messaging_archive_entries, :archivebox_id, :archive_id
  end
end
