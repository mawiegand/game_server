class AddRoomNameToMessagingJabberCommand < ActiveRecord::Migration
  def change
    add_column :messaging_jabber_commands, :room_name, :string
  end
end
