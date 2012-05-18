class CreateMessagingMessages < ActiveRecord::Migration
  def change
    create_table :messaging_messages do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.integer :type_id
      t.string :subject
      t.string :body
      t.datetime :send_at
      t.boolean :reported
      t.integer :reporter_id
      t.integer :flag

      t.timestamps
    end
  end
end
