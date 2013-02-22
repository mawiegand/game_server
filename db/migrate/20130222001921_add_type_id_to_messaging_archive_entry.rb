class AddTypeIdToMessagingArchiveEntry < ActiveRecord::Migration
  def change
    add_column :messaging_archive_entries, :type_id, :integer, :default => 0, :null => false
  end
end
