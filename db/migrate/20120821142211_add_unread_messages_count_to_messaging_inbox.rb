class AddUnreadMessagesCountToMessagingInbox < ActiveRecord::Migration
  def up
    add_column :messaging_inboxes, :unread_messages_count, :integer
    
    Messaging::Inbox.all.each { |inbox| inbox.unread_messages_count = inbox.unread_entries.count; inbox.save }
  end
  
  def down
    remove_column :messaging_inboxes, :unread_messages_count
  end
    
end
