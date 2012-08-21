class AddReadToMessagingInboxEntry < ActiveRecord::Migration
  def change
    add_column :messaging_inbox_entries, :read, :boolean, :default => false, :null => false
  end
end
