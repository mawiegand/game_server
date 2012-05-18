class CreateMessagingOutboxes < ActiveRecord::Migration
  def change
    create_table :messaging_outboxes do |t|
      t.integer :owner_id
      t.integer :messages_count

      t.timestamps
    end
  end
end
