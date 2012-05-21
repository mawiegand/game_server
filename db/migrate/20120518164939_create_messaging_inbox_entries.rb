class CreateMessagingInboxEntries < ActiveRecord::Migration
  def change
    create_table :messaging_inbox_entries do |t|
      t.integer :inbox_id
      t.integer :owner_id
      t.integer :message_id
      t.integer :sender_id
      t.string :subject

      t.timestamps
    end
  end
end
