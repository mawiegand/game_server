class AddOwnerIdToMessagingArchiveEntry < ActiveRecord::Migration
  def change
    add_column :messaging_archive_entries, :owner_id, :integer
  end
end
