class CreateMessagingOutboxEntries < ActiveRecord::Migration
  def change
    create_table :messaging_outbox_entries do |t|
      t.integer :outbox_id
      t.integer :owner_id
      t.integer :message_id
      t.integer :recipient_id
      t.string :subject

      t.timestamps
    end
  end
end
