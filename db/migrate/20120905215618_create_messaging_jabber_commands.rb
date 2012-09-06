class CreateMessagingJabberCommands < ActiveRecord::Migration
  def change
    create_table :messaging_jabber_commands do |t|
      t.integer  :character_id
      t.string   :command
      t.string   :room
      t.string   :data
      t.datetime :blocked_at
      t.string   :blocked_by
      t.boolean  :processed, :default => false, :null => false

      t.timestamps
    end
  end
end
